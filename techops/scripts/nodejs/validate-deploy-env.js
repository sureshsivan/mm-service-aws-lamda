var checkEnvConfig = function(){
    // check for env variables and throw error if required env vars are not found
    if(! process.env.AWS_CLI){
        throw new Error("AWS_CLI env var not set");
    }
    if(! process.env.AWS_ACCOUNT_ID){
        throw new Error("AWS_ACCOUNT_ID env var not set");
    }
    if(! process.env.AWS_ACCESS_KEY_ID){
        throw new Error("AWS_ACCESS_KEY_ID env var not set");
    }
    if(! process.env.AWS_SECRET_ACCESS_KEY){
        throw new Error("AWS_SECRET_ACCESS_KEY env var not set");
    }
    if(! process.env.AWS_DEFAULT_REGION){
        throw new Error("AWS_DEFAULT_REGION env var not set");
    }
    if(! process.env.AWS_REGION){
        throw new Error("AWS_REGION env var not set");
    }
    if(! process.env.APP_FULL_NAME){
        throw new Error("APP_FULL_NAME env var not set");
    }
    if(! process.env.APP_DESCRIPTION){
        throw new Error("APP_DESCRIPTION env var not set");
    }
    if(! process.env.APP_ID_UPPERCASE){
        throw new Error("APP_ID_UPPERCASE env var not set");
    }
    if(! process.env.APP_ID_LOWERCASE){
        throw new Error("APP_ID_LOWERCASE env var not set");
    }
    if(! process.env.ROOT_DOMAIN_NAME){
        throw new Error("ROOT_DOMAIN_NAME env var not set");
    }
    if(! process.env.DEPLOY_ENV){
        throw new Error("DEPLOY_ENV env var not set");
    }
    if(! process.env.ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY){
        throw new Error("ENCODED_AWS_API_G_CUST_DOMAIN_CERT_BODY env var not set");
    }
    if(! process.env.ENCODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY){
        throw new Error("ENCODED_AWS_API_G_CUST_DOMAIN_CERT_PRIVATE_KEY env var not set");
    }
    if(! process.env.ENCODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN){
        throw new Error("ENCODED_AWS_API_G_CUST_DOMAIN_CERT_CHAIN env var not set");
    }
    if(! process.env.AWS_LAMDA_BUCKET_NAME){
        throw new Error("AWS_LAMDA_BUCKET_NAME env var not set");
    }
    if(! process.env.DB_USERNAME){
        throw new Error("DB_USERNAME env var not set");
    }
    if(! process.env.DB_PASSWORD){
        throw new Error("DB_PASSWORD env var not set");
    }
    
    console.log("###################################################################################");
    console.log("##### App ENV Variables...");
    console.log("###################################################################################");
    console.log("Using ENV Variable :: AWS_CLI :: ", process.env.AWS_CLI);
    console.log("Using ENV Variable :: AWS_DEFAULT_REGION :: ", process.env.AWS_DEFAULT_REGION);
    console.log("Using ENV Variable :: AWS_REGION :: ", process.env.AWS_REGION);
    console.log("Using ENV Variable :: APP_FULL_NAME :: ", process.env.APP_FULL_NAME);
    console.log("Using ENV Variable :: APP_DESCRIPTION :: ", process.env.APP_DESCRIPTION);
    console.log("Using ENV Variable :: APP_ID_UPPERCASE :: ", process.env.APP_ID_UPPERCASE);
    console.log("Using ENV Variable :: APP_ID_LOWERCASE :: ", process.env.APP_ID_LOWERCASE);
    console.log("Using ENV Variable :: ROOT_DOMAIN_NAME :: ", process.env.ROOT_DOMAIN_NAME);
    console.log("Using ENV Variable :: DEPLOY_ENV :: ", process.env.DEPLOY_ENV);
    console.log("Using ENV Variable :: AWS_LAMDA_BUCKET_NAME :: ", process.env.AWS_LAMDA_BUCKET_NAME);
    console.log("Using ENV Variable :: DB_USERNAME :: ", process.env.DB_USERNAME);
    console.log("###################################################################################");
    console.log("###################################################################################");
};
checkEnvConfig();
