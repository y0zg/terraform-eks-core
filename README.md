# terraform-aws-core

The terraform-aws-eks component installs EKS and all required resources.

Each environment can be customized using different infrastructure building blocks with different versions.
Currently, we have two basic building blocks: **Bastion** and **EKS**.

## Repository Structure

Become familiar with the main structure of the repository:
```bash
./
├── certificates.tf
├── infra_alb.tf
├── infra_elb.tf
├── terraform.tfvars
├── main.tf
├── output.tf
├── README.md
├── terraform_config.tf
├── terraform_providers.tf
└── variables.tf
```

- `certificates.tf` - implements SSL/TLS certificates for the load balancers creation;
- `infra_alb.tf` - implements HTTP/HTTPS application load balancer pointing to all nodes creation;
- `infra_elb.tf` - implements classic load balancer pointing to all nodes creation;
- `variables.tf` - contains all variables that should be defined inside environment. It is a common practice not to define them with the default values, but it is explicitly required for user definition;
- `terraform_providers.tf` - file with terraform providers and their pinning versions. This file allows to control terraform provider versions and track that all developers are on the same version when applying infrastructure changes;
- `terraform_config.tf` - defines the remote state working procedure, the location where to store the remote state and lock flag. This file ensures that only one developer can manipulate with infrastructure from any endpoint at any time;
- `README.md` - contains some specific documentation;
- `main.tf` - defines which terraform modules to use and what parameters to pass;
- `output.tf` - implements the module output.
---

_**NOTE**: Get acquainted with the step-by-step instruction on prerequisites and corresponding installation flow by navigating to the [EKS Installation](documentation/install_eks.md) page._