Setup Instructions : 
* get/create AWS account
* create an IAM user with policy mentioned in file XX - this user will be our CI/CD deployment admin
* setup travis ci - the code here is written based on travis. can use any and would need customization.
    * make awscli available in path for whichever build you configured(travis, codeship, or plain jenkins or whatever)
    * setup environment variables
* 