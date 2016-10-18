STACK_NAME=MM-SERVERLESS-APP-API-STACKX

# check for stack existance
STACK_ALIVE=$AWS_CLI cloudformation list-stacks --stack-status-filter CREATE_COMPLETE | grep $STACK_NAME
if [ -z "$STACK_ALIVE" ]; then
  echo "Stack is already built and alive" >& 2
else
  echo "Stack was never created or dead - recreating the complete stack" >& 2
fi

#if
#echo "creating a new stack - stack does not exist"
#$AWS_CLI cloudformation create-stack \
#        --stack-name MM-SERVERLESS-APP-API-STACK \
#        --template-body file://./deploy/cf-template.json \
#        --capabilities CAPABILITY_IAM \
#        --parameters \
#            ParameterKey=MMServerlessAppBucket,ParameterValue=$AWS_LAMDA_BUCKET_NAME   \
#            ParameterKey=LambdaFunctionS3Key,ParameterValue=lambda.zip   \
#            ParameterKey=ApiGatewaySwaggerS3Key,ParameterValue=swagger2.json   \
#        --region $AWS_REGION
#else
#echo " Stack already exists - updating the existing stack"
#$AWS_CLI cloudformation update-stack \
#        --stack-name MM-SERVERLESS-APP-API-STACK \
#        --template-body file://./deploy/cf-template.json \
#        --capabilities CAPABILITY_IAM \
#        --parameters \
#            ParameterKey=MMServerlessAppBucket,ParameterValue=$AWS_LAMDA_BUCKET_NAME   \
#            ParameterKey=LambdaFunctionS3Key,ParameterValue=lambda.zip   \
#            ParameterKey=ApiGatewaySwaggerS3Key,ParameterValue=swagger2.json   \
#        --region $AWS_REGION
#fi