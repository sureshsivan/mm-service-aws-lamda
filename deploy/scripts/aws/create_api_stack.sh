$AWS_CLI cloudformation create-stack \
        --stack-name MM-SERVERLESS-APP-API-STACK \
        --template-body file://./deploy/cf-template.json \
        --capabilities CAPABILITY_IAM \
        --parameters \
            ParameterKey=MMServerlessAppBucket,ParameterValue=$AWS_LAMDA_BUCKET_NAME   \
        --region $AWS_REGION