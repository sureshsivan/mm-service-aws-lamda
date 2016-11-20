const AWS_REGION = process.env.AWS_REGION;
const AWS_ACCOUNT_ID = process.env.AWS_ACCOUNT_ID;
const LAMBDA_FN_BASE_NAME = process.env.LAMBDA_FN_BASE_NAME;
const DEPLOY_ENV = process.env.DEPLOY_ENV;
const fs = require('fs');

console.log(AWS_REGION, AWS_ACCOUNT_ID, LAMBDA_FN_BASE_NAME, DEPLOY_ENV);

var updateSwaggerFiles = function(){
    // const swaggerYamlFileAsStr = fs.readFileSync('dist/swagger2.yaml');
    const swaggerJsonFileAsStr = fs.readFileSync('dist/swagger2.json', 'utf8');
    const swaggerJsonFileAsStrModified = swaggerJsonFileAsStr
                        .replace(/#DEPLOY_ENV#/g, DEPLOY_ENV)
                        .replace(/#LAMBDA_FN_BASE_NAME#/g, LAMBDA_FN_BASE_NAME)
                        .replace(/#AWS_REGION#/g, AWS_REGION)
                        .replace(/#AWS_ACCOUNT_ID#/g, AWS_ACCOUNT_ID);

    fs.writeFileSync('dist/swagger2.json', swaggerJsonFileAsStrModified, 'utf8');
};
updateSwaggerFiles();