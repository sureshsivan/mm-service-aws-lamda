# AWS Api Gateway Test
$AWS_CLI cloudformation create-stack                                                                                \
        --stack-name TEST-API-STACK-WITH-CUSTOM-DOMAIN                                                              \
        --template-body file://./techops/deploy/test/api-custom-domain-test.yaml                                    \
        --capabilities CAPABILITY_IAM                                                                               \
        --parameters                                                                                                \
            ParameterKey=ParamApiDomainName,ParameterValue=test.$AWS_API_G_CUST_DOMAIN_NAME                         \
            ParameterKey=ParamCertificateName,ParameterValue=TEST$AWS_API_G_CUST_DOMAIN_CERT_BASE_NAME              \
            ParameterKey=ParamCertificateBody,ParameterValue=$AWS_API_G_CUST_DOMAIN_CERT_BODY                       \
            ParameterKey=ParamCertificateChain,ParameterValue=$AWS_API_G_CUST_DOMAIN_CERT_CHAIN                     \
            ParameterKey=ParamCertificatePrivateKey,ParameterValue=$AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY



# RDS TEst
$AWS_CLI cloudformation create-stack                                                                                \
        --stack-name TEST-API-STACK-WITH-CUSTOM-DOMAIN                                                              \
        --template-body file://./techops/deploy/test/api-custom-domain-test.yaml                                    \
        --capabilities CAPABILITY_IAM                                                                               \
        --parameters                                                                                                \
            ParameterKey=ParamApiDomainName,ParameterValue=test.$AWS_API_G_CUST_DOMAIN_NAME                         \
            ParameterKey=ParamCertificateName,ParameterValue=TEST$AWS_API_G_CUST_DOMAIN_CERT_BASE_NAME              \
            ParameterKey=ParamCertificateBody,ParameterValue=$AWS_API_G_CUST_DOMAIN_CERT_BODY                       \
            ParameterKey=ParamCertificateChain,ParameterValue=$AWS_API_G_CUST_DOMAIN_CERT_CHAIN                     \
            ParameterKey=ParamCertificatePrivateKey,ParameterValue=$AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY
