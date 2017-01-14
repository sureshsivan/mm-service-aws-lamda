Setup Instructions : 
* get/create AWS account
* create an IAM user with policy mentioned in file XX - this user will be our CI/CD deployment admin
* setup travis ci - the code here is written based on travis. can use any and would need customization.
    * make awscli available in path for whichever build you configured(travis, codeship, or plain jenkins or whatever)
    * setup environment variables
        * AWS_ACCOUNT_ID
        * AWS_ACCESS_KEY_ID
        * AWS_SECRET_ACCESS_KEY
        * AWS_DEFAULT_REGION
        * AWS_CLI
        * AWS_LAMDA_BUCKET_NAME
        * AWS_REGION
        * ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY
        * ENCODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY
        * ENCODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN
        * APP_FULL_NAME
        * APP_DESCRIPTION
        * APP_ID_UPPERCASE
        * APP_ID_LOWERCASE
        * ROOT_DOMAIN_NAME
        * DEPLOY_ENV - optional - defaults to dev
        * ParamVpcClassB - optional - default will be 0
        * DB_USERNAME
        * DB_PASSWORD
* 