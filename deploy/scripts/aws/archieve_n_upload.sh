#!/usr/bin/env bash
# do the archieval if needed

# loop through all the files under dist dir and if the file does not exist - delete the file with similar prefix and upload the new one
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

# form aws command based on path variable
#$AWS_CLI s3 rm s3://$AWS_LAMDA_BUCKET_NAME --region $AWS_REGION
#$AWS_CLI s3 cp dist/lambda.zip s3://$AWS_LAMDA_BUCKET_NAME --region $AWS_REGION
#$AWS_CLI s3 cp dist/swagger2.json s3://$AWS_LAMDA_BUCKET_NAME --region $AWS_REGION