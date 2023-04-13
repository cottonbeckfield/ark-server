# AWS Ark: Survival Evolved Server

### Dependencies
1. Ensure you have installed Terraform. For instructions, see Hashicorp's page: https://learn.hashicorp.com/terraform/getting-started/install.html

### Setup Server
1. Clone this repository.

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
`terraform plan -var-file=./ark.tfvars -input=false`

5. Execute template:
`terraform apply -var-file=./ark.tfvars -input=false`

6. ssh into

`ssh -i "arkkey.pem" ubuntu@ec2-54-71-238-67.us-west-2.compute.amazonaws.com`

7. follow [this link](https://github.com/arkmanager/ark-server-tools) for instructions on installing/managing ark on the server

