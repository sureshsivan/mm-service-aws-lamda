export AWS_API_GATEWAY_SECRET=3ric550n
#http://stackoverflow.com/questions/17117687/simple-openssl-string-decryption-issue

#export ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY=cat /home/suresh/tmp/3/csr_file | openssl enc -base64 -e -aes-256-cbc -nosalt -pass pass::$AWS_API_GATEWAY_SECRET
#export ENCODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY=cat /home/suresh/tmp/3/private_key | openssl enc -base64 -e -aes-256-cbc -nosalt -pass pass::$AWS_API_GATEWAY_SECRET
#export ENCODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN=cat /home/suresh/tmp/3/sivashub.com/OtherServer/root.crt | openssl enc -base64 -e -aes-256-cbc -nosalt -pass pass::$AWS_API_GATEWAY_SECRET

#export ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY=openssl enc -base64 -e -aes-256-cbc -nosalt -in /home/suresh/tmp/3/csr_file -pass pass:$AWS_API_GATEWAY_SECRET
#export DECODED_AWS_API_G_CUST_DOMAIN_CERT_BODY=echo $ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY | openssl enc -base64 -d -aes-256-cbc -nosalt -pass pass:$AWS_API_GATEWAY_SECRET

#export DECODED_AWS_API_G_CUST_DOMAIN_CERT_BODY=echo $ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY | openssl enc -base64 -d -aes-256-cbc -nosalt -pass pass:$AWS_API_GATEWAY_SECRET
#export DECODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY=echo $ENCODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY | openssl enc -base64 -d -aes-256-cbc -nosalt -pass pass:$AWS_API_GATEWAY_SECRET
#export DECODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN=echo $ENCODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN | openssl enc -base64 -d -aes-256-cbc -nosalt -pass pass:$AWS_API_GATEWAY_SECRET


export ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY=$(cat /home/suresh/tmp/3/csr_file | openssl enc -base64 -e -aes-256-cbc -nosalt -pass pass:$AWS_API_GATEWAY_SECRET)
export DECODED_AWS_API_G_CUST_DOMAIN_CERT_BODY=echo $ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY | openssl enc -base64 -d -aes-256-cbc -nosalt -pass pass:$AWS_API_GATEWAY_SECRET

echo "#######################################"
cat /home/suresh/tmp/3/csr_file
echo "#######################################"
echo $ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY
echo "#######################################"
echo $DECODED_AWS_API_G_CUST_DOMAIN_CERT_BODY
echo "#######################################"

# AWS Api Gateway Test
#$AWS_CLI cloudformation create-stack                                                                                \
#        --stack-name TEST-API-STACK-WITH-CUSTOM-DOMAIN                                                              \
#        --template-body file://./techops/deploy/test/api-custom-domain-test.yaml                                    \
#        --capabilities CAPABILITY_IAM                                                                               \
#        --parameters                                                                                                \
#            ParameterKey=ParamApiDomainName,ParameterValue=test.$AWS_API_G_CUST_DOMAIN_NAME                         \
#            ParameterKey=ParamCertificateName,ParameterValue=TEST$AWS_API_G_CUST_DOMAIN_CERT_BASE_NAME              \
#            ParameterKey=ParamCertificateBody,ParameterValue=$DECODED_AWS_API_G_CUST_DOMAIN_CERT_BODY                       \
#            ParameterKey=ParamCertificateChain,ParameterValue=$DECODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN                     \
#            ParameterKey=ParamCertificatePrivateKey,ParameterValue=$DECODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY
#
#
#
## RDS TEst
#$AWS_CLI cloudformation create-stack                                                                                \
#        --stack-name TEST-API-STACK-WITH-CUSTOM-DOMAIN                                                              \
#        --template-body file://./techops/deploy/test/api-custom-domain-test.yaml                                    \
#        --capabilities CAPABILITY_IAM                                                                               \
#        --parameters                                                                                                \
#            ParameterKey=ParamApiDomainName,ParameterValue=test.$AWS_API_G_CUST_DOMAIN_NAME                         \
#            ParameterKey=ParamCertificateName,ParameterValue=TEST$AWS_API_G_CUST_DOMAIN_CERT_BASE_NAME              \
#            ParameterKey=ParamCertificateBody,ParameterValue=$DECODED_AWS_API_G_CUST_DOMAIN_CERT_BODY                       \
#            ParameterKey=ParamCertificateChain,ParameterValue=$DECODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN                     \
#            ParameterKey=ParamCertificatePrivateKey,ParameterValue=$DECODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY
