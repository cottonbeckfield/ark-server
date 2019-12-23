# AWS Ark: Survival Evolved Server

### Dependencies
1. Ensure you have installed Terraform. For instructions, see Hashicorp's page: https://learn.hashicorp.com/terraform/getting-started/install.html

### Setup Server
1. Clone this repoistory.

2. Ensure the directory is initialized with Terraform by running terraform init from inside the directory:
`terraform init`

3. Update ark.tfvars to have relevant information. Example:
```
region = "us-west-2"
access_key = "ADFADFASFASFA"
secret_key = "ASDFASDFASDFA"
key_name = "ark"
```
4. Test the template to ensure it's working:
`terraform plan -var-file=./terraform.tfvars -input=false`

5. Execute template:
`terraform apply -var-file=./ark.tfvars -input=false`
