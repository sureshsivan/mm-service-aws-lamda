const AWS_REGION = process.env.AWS_REGION;
const AWS_ACCOUNT_ID = process.env.AWS_ACCOUNT_ID;
const LAMBDA_FN_NAME = process.env.DEPLOY_ENV + process.env.APP_ID_UPPERCASE + 'ApiLambdaFunction';
const DEPLOY_ENV = process.env.DEPLOY_ENV;
const fs = require('fs');

var updateSwaggerFiles = function(){
    // const swaggerYamlFileAsStr = fs.readFileSync('dist/swagger2.yaml');
    const swaggerJsonFileAsStr = fs.readFileSync('dist/swagger2.json', 'utf8');
    const swaggerJsonFileAsStrModified = swaggerJsonFileAsStr
                        .replace(/#DEPLOY_ENV#/g, DEPLOY_ENV)
                        .replace(/#AWS_REGION#/g, AWS_REGION)
                        .replace(/#LAMBDA_FN_NAME#/g, LAMBDA_FN_NAME)
                        .replace(/#AWS_ACCOUNT_ID#/g, AWS_ACCOUNT_ID);

    fs.writeFileSync('dist/swagger2.json', swaggerJsonFileAsStrModified, 'utf8');
};
updateSwaggerFiles();