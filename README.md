Running with Terraform:

Ensure the directory is initialized with Terraform by running terraform init from inside the directory:
`terraform init`

Make sure to update the ark.tfvars with your values, then run:
`terraform apply -var-file=./ark.tfvars -input=false`
