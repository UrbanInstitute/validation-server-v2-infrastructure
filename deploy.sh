#!/bin/bash

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

echo $BACKEND_MASTER_USER_PASSWORD

aws cloudformation deploy \
  --stack-name sdt-validation-server-infrastructure \
  --template-file template.yml \
  --capabilities CAPABILITY_NAMED_IAM \
  --region $Region \
  --profile $Profile \
  --parameter-overrides \
    BackendMasterUserPassword=$BACKEND_MASTER_USER_PASSWORD \
    S3BucketName=$S3BucketName \
    DBPrivateSubnet=$DBPrivateSubnet \
    EC2PublicSubnet=$EC2PublicSubnet \
    EC2SecurityGroup=$EC2SecurityGroup \
    TagName=$Tag_Name \
    TagProjectName=$Tag_ProjectName \
    TagProjectCode=$Tag_ProjectCode \
    TagTechTeam=$Tag_TechTeam \
    TagCenter=$Tag_Center \
    TagRequestedBy=$Tag_RequestedBy \
    TagCreatedBy=$Tag_CreatedBy \
    VpcId=$VpcId \
    TagPlatform=$Tag_Platform \
    DBSecurityGroup=$DBSecurityGroup

