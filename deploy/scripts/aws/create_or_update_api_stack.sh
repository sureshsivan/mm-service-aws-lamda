#!/usr/bin/env bash
STACK_NAME=MM-SERVERLESS-APP-API-STACK
# check for stack existance
STACK_ALIVE="$("$AWS_CLI" cloudformation list-stacks --stack-status-filter CREATE_COMPLETE | grep "$STACK_NAME")"

if [ -z "$STACK_ALIVE" ]; then
    echo "[INFO] Serverless Stack was never created or dead - recreating the complete stack : CREATING NEW STACK" >& 2
    $AWS_CLI cloudformation create-stack \
            --stack-name MM-SERVERLESS-APP-API-STACK \
            --template-body file://./deploy/cf-template-serverless-stack.json \
            --capabilities CAPABILITY_IAM \
            --parameters \
                ParameterKey=MMServerlessAppBucket,ParameterValue=$AWS_LAMDA_BUCKET_NAME   \
                ParameterKey=LambdaFunctionS3Key,ParameterValue=lambda.zip   \
                ParameterKey=ApiGatewaySwaggerS3Key,ParameterValue=swagger2.json   \
            --region $AWS_REGION
    echo "[INFO] STACK CREATION : Kicked Off"
else
    echo "[INFO] Serverless Stack was already built and alive : UPDATING EXISTING STACK" >& 2
    $AWS_CLI cloudformation update-stack \
            --stack-name MM-SERVERLESS-APP-API-STACK \
            --template-body file://./deploy/cf-template-serverless-stack.json \
            --capabilities CAPABILITY_IAM \
            --parameters \
                ParameterKey=MMServerlessAppBucket,ParameterValue=$AWS_LAMDA_BUCKET_NAME   \
                ParameterKey=LambdaFunctionS3Key,ParameterValue=lambda.zip   \
                ParameterKey=ApiGatewaySwaggerS3Key,ParameterValue=swagger2.json   \
            --region $AWS_REGION
    echo "[INFO] STACK UPDATE : Kicked Off"
fi