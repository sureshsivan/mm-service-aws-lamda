# form aws command based on path variable
$AWS_CLI s3 rm s3://$AWS_LAMDA_BUCKET_NAME --region $AWS_REGION
$AWS_CLI s3 cp dist/lambda.zip s3://$AWS_LAMDA_BUCKET_NAME --region $AWS_REGION
$AWS_CLI s3 cp dist/swagger2.json s3://$AWS_LAMDA_BUCKET_NAME --region $AWS_REGION