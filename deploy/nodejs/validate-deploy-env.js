
var checkEnvConfig = function(){
    // export AWS_CLI=/usr/bin/aws
    // export AWS_REGION=us-east-1
    // export AWS_LAMDA_BUCKET_NAME=mm-lambda-deployments
    // export AWS_ACCOUNT_ID=
    //  export AWS_ACCESS_KEY_ID=
    //  export AWS_SECRET_ACCESS_KEY=

    // check for env variables and throw error if required env vars are not found
    if(! process.env.AWS_CLI){
        throw new Error("AWS_CLI env var not set");
    }
    if(! process.env.AWS_REGION){
        throw new Error("AWS_REGION env var not set");
    }
    if(! process.env.AWS_LAMDA_BUCKET_NAME){
        throw new Error("AWS_LAMDA_BUCKET_NAME env var not set");
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
    if(! process.env.STACK_NAME){
        throw new Error("STACK_NAME env var not set");
    }
    if(! process.env.AWS_DEFAULT_REGION){
        throw new Error("AWS_DEFAULT_REGION env var not set");
    }
};
checkEnvConfig();