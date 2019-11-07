terraform-aws-core
------------------

Install EKS and all required resources

Each environment can be customize using different infrastructure building blocks with different versions.
We have 3 basic building blocks:

- bastion
- eks

Repo structure
--------------

```bash
./
├── terraform.tfvars
├── main.tf
├── README.md
├── terraform_config.tf
├── terraform_providers.tf
└── variables.tf
```

- `variables.tf` - contains all variables that should be defined inside environment. It is common practice not to define them with default values but explicitly require for user definition;
- `terraform_providers.tf` - file with terraform providers and and their pinning versions. Ensures that we can control terraform provider versions and all developers are on the same version when apply changes to infrastructure;
- `terraform_config.tf` - defines remote state working procedure, where to store remote state and lock flag. Ensures that the onle one developer at any time can manipulate with infrastructure from any endpoint;
- `README.md` - contains some specific documentation on env
- `main.tf` - defines which terraform modules to use and what parameters to pass.

Update `terraform_config.tf` file with proper backend key value which should be unique
to store your terraform state for current deployment, see e.g. bellow:

```bash
key = "terraform-aws-core/eu-central-1/terraform/terraform.tfstate"
```

Modify `terraform_config.tf` according to your environment values

```bash
  backend "s3" {
    bucket         = "terraform-states-<AWS_ACCOUNT_ID>"
    key            = "terraform-aws-core/eu-central-1/terraform/terraform.tfstate"
    region         = "eu-central-1"
    acl            = "bucket-owner-full-control"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
```

How to run terraform
--------------------

Ensure you have [aws-aim-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html) is installed before running terraform

In general working with terraform has several steps:

1. `terraform init` - to initialize remote state and download modules
2. `terraform plan` - to check what changes are going to be made, dry-run
2. `terraform apply -auto-approve=false` - run terraform plan and if everything is ok then apply changes

Example:

```bash
# AWS_PROFILE - provide profile which is configured for deploying EKS, e.g.terraform-auto-user
$ AWS_REGION=eu-central-1 AWS_PROFILE=terraform-auto-user terraform init
$ AWS_REGION=eu-central-1 AWS_PROFILE=terraform-auto-user terraform apply -auto-approve=false
```
