$AWS_CLI cloudformation update-stack \
    --stack-name $npm_package_config_cloudFormationStackName \
    --template-body file://./cloudformation.json \
    --capabilities CAPABILITY_IAM \
    --parameters \
        ParameterKey=AwsServerlessExpressS3Bucket,ParameterValue=$npm_package_config_s3BucketName \
    --region $npm_package_config_region