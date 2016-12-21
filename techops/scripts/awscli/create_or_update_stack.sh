#!/usr/bin/env bash

#  Utils
function error_exit {
    echo "$1" >&2   ## Send message to stderr. Exclude >&2 if you don't want it that way.
    exit "${2:-1}"  ## Return a code specified by $2 or 1 by default.
}



# check for stack existance
# TODO : Check based on all status codes
# TODO : use http://docs.aws.amazon.com/cli/latest/reference/cloudformation/wait/stack-exists.html
#CREATE NEW STACK IF [CREATE_FAILED, DELETE_COMPLETE]
# Update Stack if [CREATE_COMPLETE, UPDATE_COMPLETE, UPDATE_COMPLETE_CLEANUP_IN_PROGRESS, DELETE_FAILED, UPDATE_ROLLBACK_FAILED, UPDATE_ROLLBACK_COMPLETE]
# Wait and create a new stacks if [ROLLBACK_IN_PROGRESS, DELETE_IN_PROGRESS]
# Wait and update stack if [CREATE_IN_PROGRESS, UPDATE_IN_PROGRESS, UPDATE_ROLLBACK_IN_PROGRESS, UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS]


STACK_NAME=$DEPLOY_ENV-$APP_ID_UPPERCASE-STACK
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

# check whether LAMBDA_FILE_NAME and SWAGGER_FILE_NAME has proper value and return a non zero exit code if not
# no need to trigger the build.
if [ -z "LAMBDA_FILE_NAME" ]; then
    echo "Error locating lambda file in bucket:$AWS_LAMDA_BUCKET_NAME"
    exit 51
else
    echo "Using Lambda file : $LAMBDA_FILE_NAME"
fi

if [ -z "SWAGGER_FILE_NAME" ]; then
    echo "Error locating swagger2 file in bucket:$AWS_LAMDA_BUCKET_NAME"
    exit 61
else
    echo "Using Lambda file : $SWAGGER_FILE_NAME"
fi

if [ -z "$STACK_ALIVE" ]; then
    echo "[INFO] ${STACK_NAME} Stack was never created or dead - recreating the complete stack : CREATING NEW STACK" >& 2
    $AWS_CLI cloudformation create-stack                                                                                            \
            --stack-name $STACK_NAME                                                                                                \
            --template-body $CF_STACK_FILE                                                                                          \
            --capabilities CAPABILITY_IAM                                                                                           \
            --parameters                                                                                                            \
                ParameterKey=ParamAppFullName,ParameterValue=$APP_FULL_NAME                                                         \
                ParameterKey=ParamAppDescription,ParameterValue=$APP_DESCRIPTION                                                    \
                ParameterKey=ParamAppIdentifierCaps,ParameterValue=$APP_ID_UPPERCASE                                                \
                ParameterKey=ParamAppIdentifierSmall,ParameterValue=$APP_ID_LOWERCASE                                               \
                ParameterKey=ParamRootDomain,ParameterValue=$ROOT_DOMAIN_NAME                                                       \
                ParameterKey=ParamDeployEnv,ParameterValue=$DEPLOY_ENV                                                              \
                ParameterKey=ParamDbUsername,ParameterValue=$DB_USERNAME                                                            \
                ParameterKey=ParamDbPassword,ParameterValue=$DB_PASSWORD                                                            \
                ParameterKey=ParamCertificateBodyEncoded,ParameterValue=$ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY                    \
                ParameterKey=ParamCertificateChainEncoded,ParameterValue=$ENCODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN                  \
                ParameterKey=ParamCertificatePrivateKeyEncoded,ParameterValue=$ENCODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY       \
                ParameterKey=ParamAssetBucket,ParameterValue=$AWS_LAMDA_BUCKET_NAME                                                 \
                ParameterKey=ParamLambdaZipFile,ParameterValue=$LAMBDA_FILE_NAME                                                    \
                ParameterKey=ParamSwaggerFile,ParameterValue=$SWAGGER_FILE_NAME                                                     \
            --region $AWS_REGION
    echo "[INFO] STACK CREATION : Kicked Off"
else
    echo "[INFO] ${STACK_NAME} Stack was already built and alive : UPDATING EXISTING STACK" >& 2
    $AWS_CLI cloudformation update-stack                                                                                            \
            --stack-name $STACK_NAME                                                                                                \
            --template-body $CF_STACK_FILE                                                                                          \
            --capabilities CAPABILITY_IAM                                                                                           \
            --parameters                                                                                                            \
                ParameterKey=ParamAppFullName,ParameterValue=$APP_FULL_NAME                                                         \
                ParameterKey=ParamAppDescription,ParameterValue=$APP_DESCRIPTION                                                    \
                ParameterKey=ParamAppIdentifierCaps,ParameterValue=$APP_ID_UPPERCASE                                                \
                ParameterKey=ParamAppIdentifierSmall,ParameterValue=$APP_ID_LOWERCASE                                               \
                ParameterKey=ParamRootDomain,ParameterValue=$ROOT_DOMAIN_NAME                                                       \
                ParameterKey=ParamDeployEnv,ParameterValue=$DEPLOY_ENV                                                              \
                ParameterKey=ParamDbUsername,ParameterValue=$DB_USERNAME                                                            \
                ParameterKey=ParamDbPassword,ParameterValue=$DB_PASSWORD                                                            \
                ParameterKey=ParamCertificateBodyEncoded,ParameterValue=$ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY                    \
                ParameterKey=ParamCertificateChainEncoded,ParameterValue=$ENCODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN                  \
                ParameterKey=ParamCertificatePrivateKeyEncoded,ParameterValue=$ENCODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY       \
                ParameterKey=ParamAssetBucket,ParameterValue=$AWS_LAMDA_BUCKET_NAME                                                 \
                ParameterKey=ParamLambdaZipFile,ParameterValue=$LAMBDA_FILE_NAME                                                    \
                ParameterKey=ParamSwaggerFile,ParameterValue=$SWAGGER_FILE_NAME                                                     \
            --region $AWS_REGION
    echo "[INFO] STACK UPDATE : Kicked Off"
fi
