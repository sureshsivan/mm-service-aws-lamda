#!/usr/bin/env bash
# check for stack existance
# TODO : Check based on all status codes
# TODO : use http://docs.aws.amazon.com/cli/latest/reference/cloudformation/wait/stack-exists.html
#CREATE NEW STACK IF [CREATE_FAILED, DELETE_COMPLETE]
# Update Stack if [CREATE_COMPLETE, UPDATE_COMPLETE, UPDATE_COMPLETE_CLEANUP_IN_PROGRESS, DELETE_FAILED, UPDATE_ROLLBACK_FAILED, UPDATE_ROLLBACK_COMPLETE]
# Wait and create a new stacks if [ROLLBACK_IN_PROGRESS, DELETE_IN_PROGRESS]
# Wait and update stack if [CREATE_IN_PROGRESS, UPDATE_IN_PROGRESS, UPDATE_ROLLBACK_IN_PROGRESS, UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS]


if [ "$DEPLOY_ENV" == "" ]; then
    DEPLOY_ENV=dev
fi

if [ "$DEPLOY_ENV" != "prod" ]; then
    APP_DOMAIN_NAME=$DEPLOY_ENV.$APP_DOMAIN_NAME
fi

STACK_NAME=$STACK_NAME-$DEPLOY_ENV

CF_STACK_FILE="file://.build/stack-template.yaml"

#  X CREATE_IN_PROGRESS
#  X CREATE_FAILED
#  X CREATE_COMPLETE
#  X ROLLBACK_IN_PROGRESS
#  ROLLBACK_FAILED
#  ROLLBACK_COMPLETE
#  X DELETE_IN_PROGRESS
#  X DELETE_FAILED
#  X DELETE_COMPLETE
#  X UPDATE_IN_PROGRESS
#  X UPDATE_COMPLETE_CLEANUP_IN_PROGRESS
#  X UPDATE_COMPLETE
#  X UPDATE_ROLLBACK_IN_PROGRESS
#  X UPDATE_ROLLBACK_FAILED
#  X UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS
#  X UPDATE_ROLLBACK_COMPLETE
STACK_ALIVE="$("$AWS_CLI" cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE | grep "$STACK_NAME")"

LAMBDA_FILE_NAME="$(aws s3 ls s3://"$AWS_LAMDA_BUCKET_NAME" | grep -o "lambda.*.zip")"
SWAGGER_FILE_NAME="$(aws s3 ls s3://"$AWS_LAMDA_BUCKET_NAME" | grep -o "swagger2.*.json")"
LAMBDA_FN_NAME=$DEPLOY_ENV-$LAMBDA_FN_BASE_NAME
echo "Using Bucket : " $AWS_LAMDA_BUCKET_NAME
echo "Using Lambda File : " $LAMBDA_FILE_NAME
echo "Using Swagger File : " $SWAGGER_FILE_NAME

if [ -z "$STACK_ALIVE" ]; then
    echo "[INFO] ${STACK_NAME} Stack was never created or dead - recreating the complete stack : CREATING NEW STACK" >& 2
    $AWS_CLI cloudformation create-stack                                            \
            --stack-name $STACK_NAME                                                \
            --template-body $CF_STACK_FILE                                          \
            --capabilities CAPABILITY_IAM                                           \
            --parameters                                                            \
                ParameterKey=ParamRootDomain,ParameterValue=$ROOT_DOMAIN_NAME       \
                ParameterKey=ParamAppDomain,ParameterValue=$APP_DOMAIN_NAME         \
                ParameterKey=ParamAssetBucket,ParameterValue=$AWS_LAMDA_BUCKET_NAME \
                ParameterKey=ParamLambdaZipFile,ParameterValue=$LAMBDA_FILE_NAME    \
                ParameterKey=ParamSwaggerFile,ParameterValue=$SWAGGER_FILE_NAME     \
                ParameterKey=ParamLambdaFnName,ParameterValue=$LAMBDA_FN_NAME       \
            --region $AWS_REGION
    echo "[INFO] STACK CREATION : Kicked Off"
else
    echo "[INFO] ${STACK_NAME} Stack was already built and alive : UPDATING EXISTING STACK" >& 2
    $AWS_CLI cloudformation update-stack                                            \
            --stack-name $STACK_NAME                                                \
            --template-body $CF_STACK_FILE                                          \
            --capabilities CAPABILITY_IAM                                           \
            --parameters                                                            \
                ParameterKey=ParamRootDomain,ParameterValue=$ROOT_DOMAIN_NAME       \
                ParameterKey=ParamAppDomain,ParameterValue=$APP_DOMAIN_NAME         \
                ParameterKey=ParamAssetBucket,ParameterValue=$AWS_LAMDA_BUCKET_NAME \
                ParameterKey=ParamLambdaZipFile,ParameterValue=$LAMBDA_FILE_NAME    \
                ParameterKey=ParamSwaggerFile,ParameterValue=$SWAGGER_FILE_NAME     \
                ParameterKey=ParamLambdaFnName,ParameterValue=$LAMBDA_FN_NAME       \
            --region $AWS_REGION
    echo "[INFO] STACK UPDATE : Kicked Off"
fi