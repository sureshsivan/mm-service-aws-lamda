const AWS_REGION = process.env.AWS_REGION;
const AWS_ACCOUNT_ID = process.env.AWS_ACCOUNT_ID;
const fs = require('fs');

var checkConfig = function(){
    // check for env variables and throw error
}

var updateSwaggerFiles = function(){
    // const swaggerYamlFileAsStr = fs.readFileSync('dist/swagger2.yaml');
    const swaggerJsonFileAsStr = fs.readFileSync('dist/swagger2.json', 'utf8');
    const swaggerJsonFileAsStrModified = swaggerJsonFileAsStr
                        .replace(/AWS_REGION/g, AWS_REGION)
                        .replace(/AWS_ACCOUNT_ID/g, AWS_ACCOUNT_ID);

    fs.writeFileSync('dist/swagger2.json', swaggerJsonFileAsStrModified, 'utf8');
};
checkConfig();
updateSwaggerFiles();