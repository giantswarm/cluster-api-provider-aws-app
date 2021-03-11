[![CircleCI](https://circleci.com/gh/giantswarm/cluster-api-provider-aws-app.svg?style=shield)](https://circleci.com/gh/giantswarm/cluster-api-provider-aws-app)

# cluster-api-provider-aws-app
Cluster API AWS controller packaged as a Giant Swarm app

# Prerequisites
The CAPA controllers need access and permissions to create resources in the management-clusters AWS-account. This is how we currently set them up. In the future this should be part of spinning up a new installation.

Tools you need:
- `opsctl`:
- `aws-cli`:
- `clusterawsadm`

## Access the installations AWS account
Find the serial number of your MFA device.
```
aws iam list-mfa-devices --output json --no-cli-pager
```
Get an MFA token on your device and enter it like this
```
aws sts get-session-token --serial-number  $SERIAL_NUMBER --token-code $TOKEN
```
Export the credentials you get here.
```
export AWS_ACCESS_KEY_ID=[...]
export AWS_SECRET_ACCESS_KEY=[...]
export AWS_SESSION_TOKEN=[...]
``` 
Use `opsctl` to find the management cluster AWS account on your installation.
```
opsctl open -a cloudprovider -i $INSTALLATION --tenant-cluster default --no-browser
```
It will give you something like
```
[...]
Role to assume: `$ARN`
[...]
```
Assume this role.
```
aws sts assume-role  --role-arn $ARN --role-session-name $YOURNAME
```

## Create Policies and Roles for CAPA
```
export AWS_REGION=$INSTALLATION_REGION
export AWS_ACCESS_KEY_ID=[...]
export AWS_SECRET_ACCESS_KEY=[...]
export AWS_SESSION_TOKEN=[...]
```
Create cloud formation stack in your account which contains your needed resources.
```
clusterawsadm bootstrap iam create-cloudformation-stack
```
The output will give you the policies that have been created for the next step.

## Create a user for the CAPA-Controller
Create the user
```
aws iam create-user --user-name $INSTALLATION-capa-controller
```
Attach the controller policy from the previous step like so
```
aws iam attach-user-policy --user-name $INSTALLATION-capa-controller ----policy-arn arn:aws:iam::$ACCOUNT:policy/controllers.cluster-api-provider-aws.sigs.k8s.io
```

## Set Credentials
Create the access key
```
aws iam create-access-key --user-name $INSTALLATION-capa-controller
```
You should now have all the following:

- `AccessKeyId`
- `SecretAccessKey`
- `Region` (The same region from previous steps)

These credentials will be used in the CAPA controllers secret. It looks like this:

```
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: <some name>
  namespace: <some namespace>
stringData:
  credentials: |-
    [default]
    aws_access_key_id: < AccessKeyId >
    aws_secret_access_key: < SecretAccessKey >
    region: < Region >
```

 For use on your installation, they should be added to the `$INSTALLATION/draughtsman-secret-values.yaml` in the [installations](https://github.com/giantswarm/installations) repo.

```
Installation:
  V1:
    Secret:
      CAPI:
        AWS:
          AccessKeyId: [...]
          SecretAccessKey: [...]
          Region: [...]
```
        
