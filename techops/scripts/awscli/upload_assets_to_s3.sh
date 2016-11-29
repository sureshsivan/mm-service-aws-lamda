#!/usr/bin/env bash

if [ "$DEPLOY_ENV" == "" ]; then
    DEPLOY_ENV=dev
fi

if [ "$DEPLOY_ENV" != "prod" ]; then
    APP_DOMAIN_NAME=$DEPLOY_ENV.$APP_DOMAIN_NAME
fi

#// check for bucket existance and create if not exist

for filepath in dist/*.*
do
    filename=${filepath##*/}
    AWS_S3_FILE="$("$AWS_CLI" s3 ls s3://"$AWS_LAMDA_BUCKET_NAME"/"$filename")"
    if [ -z "$AWS_S3_FILE" ]; then
#       no file with same name found in s3 - file name checksum and content changed in this build
#       so delete and upload new file
        extension=${filename##*.}
        prefix="${filename%.*.*}"
        include=$prefix.*.$extension
        echo "Delete Old Deployment Artifact with pattern : " $include
        $AWS_CLI s3 rm s3://$AWS_LAMDA_BUCKET_NAME --region $AWS_REGION --recursive --exclude "*" --include $include
        echo "Uploading new Deployment Artifact : " $filepath
        $AWS_CLI s3 cp $filepath s3://$AWS_LAMDA_BUCKET_NAME --region $AWS_REGION
    else
        echo "Deployment Artifact Unchanged : " $filepath
    fi
done