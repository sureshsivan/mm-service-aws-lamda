#!/usr/bin/env bash
#export AWS_API_GATEWAY_SECRET=3ric550n
#http://stackoverflow.com/questions/17117687/simple-openssl-string-decryption-issue
#
#export ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY=cat /home/suresh/tmp/3/csr_file | openssl enc -base64 -e -aes-256-cbc -nosalt -pass pass::$AWS_API_GATEWAY_SECRET
#export ENCODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY=cat /home/suresh/tmp/3/private_key | openssl enc -base64 -e -aes-256-cbc -nosalt -pass pass::$AWS_API_GATEWAY_SECRET
#export ENCODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN=cat /home/suresh/tmp/3/sivashub.com/OtherServer/root.crt | openssl enc -base64 -e -aes-256-cbc -nosalt -pass pass::$AWS_API_GATEWAY_SECRET
#
#export ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY=openssl enc -base64 -e -aes-256-cbc -nosalt -in /home/suresh/tmp/3/csr_file -pass pass:$AWS_API_GATEWAY_SECRET
#export ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY=echo $ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY | openssl enc -base64 -d -aes-256-cbc -nosalt -pass pass:$AWS_API_GATEWAY_SECRET
#
#export ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY=echo $ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY | openssl enc -base64 -d -aes-256-cbc -nosalt -pass pass:$AWS_API_GATEWAY_SECRET
#export ENCODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY=echo $ENCODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY | openssl enc -base64 -d -aes-256-cbc -nosalt -pass pass:$AWS_API_GATEWAY_SECRET
#export ENCODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN=echo $ENCODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN | openssl enc -base64 -d -aes-256-cbc -nosalt -pass pass:$AWS_API_GATEWAY_SECRET
#
#
#export ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY=$(cat /home/suresh/tmp/3/csr_file | openssl enc -base64 -e -aes-256-cbc -nosalt -pass pass:$AWS_API_GATEWAY_SECRET)
#export ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY=echo $ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY | openssl enc -base64 -d -aes-256-cbc -nosalt -pass pass:$AWS_API_GATEWAY_SECRET
#
#var fs = require('fs');
#exports = module.exports = function(){
#    function base64_encode(file) {
#        // read binary data
#        var bitmap = fs.readFileSync(file);
#        // convert binary data to base64 encoded string
#        return new Buffer(bitmap).toString('base64');
#    }
#
#    function base64_decode(base64str) {
#        // create buffer object from base64 encoded string, it is important to tell the constructor that the string is base64 encoded
#        var decoded = new Buffer(base64str, 'base64').toString('ascii');
#        // write buffer to file
#        return decoded;
#    }
#
#    var certBody = base64_encode('/home/suresh/tmp/3/csr_file');
#    var certPrivateKey = base64_encode('/home/suresh/tmp/3/private_key');
#    var certChain = base64_encode('/home/suresh/tmp/3/sivashub.com/OtherServer/root.crt');
#    console.log("###### BASE 64 ENCODED CERT Body##########");
#    console.log(certBody);
#    console.log("###### BASE 64 ENCODED CERT Private Key##########");
#    console.log(certPrivateKey);
#    console.log("###### BASE 64 ENCODED CERT Chain##########");
#    console.log(certChain);
#};
#
#echo "#######################################"
#cat /home/suresh/tmp/3/csr_file
#echo "#######################################"
#echo $ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY
#echo "#######################################"
#echo $ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY
#echo "#######################################"
#

#
#
# AWS Api Gateway Test
#$AWS_CLI cloudformation create-stack                                                                                \
#        --stack-name TEST-API-STACK-WITH-CUSTOM-DOMAIN-X1                                                             \
#        --template-body file://./techops/deploy/test/api-custom-domain-test.yaml                                    \
#        --capabilities CAPABILITY_IAM                                                                               \
#        --parameters                                                                                                \
#            ParameterKey=ParamApiDomainName,ParameterValue=test.$AWS_API_G_CUST_DOMAIN_NAME                         \
#            ParameterKey=ParamCertificateName,ParameterValue=TEST$AWS_API_G_CUST_DOMAIN_CERT_BASE_NAME              \
#            ParameterKey=ParamCertificateBodyEncoded,ParameterValue=$ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY                       \
#            ParameterKey=ParamCertificateChainEncoded,ParameterValue=$ENCODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN                     \
#            ParameterKey=ParamCertificatePrivateKeyEncoded,ParameterValue=$ENCODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY


$AWS_CLI cloudformation create-stack                                                                                \
        --stack-name TEST-API-STACK-WITH-CUSTOM-DOMAIN-X1                                                           \
        --template-body file://./techops/deploy/test/rds-test                                                       \
        --capabilities CAPABILITY_IAM                                                                               \
        --parameters                                                                                                \
            ParameterKey=ParamApiDomainName,ParameterValue=test.$AWS_API_G_CUST_DOMAIN_NAME                         \
            ParameterKey=ParamCertificateName,ParameterValue=TEST$AWS_API_G_CUST_DOMAIN_CERT_BASE_NAME              \
            ParameterKey=ParamCertificateBodyEncoded,ParameterValue=$ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY                       \
            ParameterKey=ParamCertificateChainEncoded,ParameterValue=$ENCODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN                     \
            ParameterKey=ParamCertificatePrivateKeyEncoded,ParameterValue=$ENCODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY

# RDS TEst
#$AWS_CLI cloudformation create-stack                                                                                \
#        --stack-name TEST-API-STACK-WITH-CUSTOM-DOMAIN                                                              \
#        --template-body file://./techops/deploy/test/api-custom-domain-test.yaml                                    \
#        --capabilities CAPABILITY_IAM                                                                               \
#        --parameters                                                                                                \
#            ParameterKey=ParamApiDomainName,ParameterValue=test.$AWS_API_G_CUST_DOMAIN_NAME                         \
#            ParameterKey=ParamCertificateName,ParameterValue=TEST$AWS_API_G_CUST_DOMAIN_CERT_BASE_NAME              \
#            ParameterKey=ParamCertificateBodyEncoded,ParameterValue=$ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY                       \
#            ParameterKey=ParamCertificateChainEncoded,ParameterValue=$ENCODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN                     \
#            ParameterKey=ParamCertificatePrivateKeyEncoded,ParameterValue=$ENCODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY
