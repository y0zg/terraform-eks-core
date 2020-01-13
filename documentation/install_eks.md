# EKS Installation

In order to use the terraform-aws-core component, pay attention to the following prerequisites:

* AWS profile is configured;
* [terraform](https://www.terraform.io/downloads.html) is installed;
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) is installed;
* [aws-aim-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html) is installed before running terraform.

## How to Install EKS

Explore the steps below to install EKS correctly:

#### 1. Copy all files from repository root to a separate folder

_**NOTE**: It is highly recommended to copy the terraform installation files for every EKS cluster to separate folders, e.g. epmd-edp/delivery._

#### 2. Update the terraform_config.tf file

Update the `terraform_config.tf` file with a proper backend key value, which should be unique to store your terraform state for the current deployment in S3 bucket:

```bash
  backend "s3" {
    bucket         = "terraform-states-<AWS_ACCOUNT_ID>"
    key            = "<CLUSTER_NAME>/<REGION>/terraform/terraform.tfstate"
    region         = "<REGION>"
    acl            = "bucket-owner-full-control"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
```

#### 3. Create AWS objects

In order to use the module, create manually the following objects in AWS:

* VPC in selected region. It is recommended to create VPC with /16 CIDR;
* IAM role for EKS cluster according to the requirements - https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html;
* IAM role for the worker nodes according to the requirements - https://docs.aws.amazon.com/eks/latest/userguide/worker_node_IAM_role.html;
* SSH key pair that will be used for SSH access to the worker nodes.

#### 4. Update the terraform.tfvars file

This file contains the EKS cluster deployment specific values for variables that are defined in variables.tf. 
Set values for your EKS cluster deployment, see below the variables description:

```bash
region = "<AWS_REGION_NAME>"
platform_name = "<EKS_CLUSTER_NAME>"
vpc_id        = "<VPC_ID>"
platform_cidr = "<VPC_CIDR>"
```

Set this value if you have private subnets already created in your VPC:
```bash
private_subnets_id = ["<PRIVATE_SUBNET1_ID>","<PRIVATE_SUBNET2_ID>",...,"<PRIVATE_SUBNETX_ID>"]
```
Set this value if you want private subnets to be created by Terraform:
```bash
private_cidrs = ["<PRIVATE_SUBNET1_CIDR>", "<PRIVATE_SUBNET2_CIDR>",..., "<PRIVATE_SUBNETX_CIDR>"]
```
Set this value if you have public subnets already created in your VPC:
```bash
public_subnets_id = ["<PUBLIC_SUBNET1_ID>","<PUBLIC_SUBNET2_ID>",...,"<PUBLIC_SUBNETX_ID>"]
```
Set this value if you want public subnets to be created by Terraform:
```bash
public_cidrs = ["<PUBLIC_SUBNET1_CIDR>", "<PUBLIC_SUBNET2_CIDR>",..., "<PUBLIC_SUBNETX_CIDR>"]
```
Set this value to one of the supported versions according to [AWS documentation](https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html). 
Set the version of the MAJOR.MINOR format, for example, 1.13.
```bash
cluster_version           = "<EKS_CLUSTER_VERSION>"
```

Set cluster and worker security groups to the VPC default:
```bash
cluster_security_group_id = "<VPC_DEFAULT_SECURITY_GROUP>"
worker_security_group_id  = "<VPC_DEFAULT_SECURITY_GROUP>"
```

Set the following parameters according to the manually created AWS objects:
```bash
cluster_iam_role_name = "<IAM_ROLE_FOR_EKS_CLUSTER_ID>"
worker_iam_instance_profile_name = "<IAM_ROLE_FOR_EKS_CLUSTER_ID>"
key_name = "<SSH_KEY_PAIR_NAME>"
```

The "map_users" variable contains AWS users mappings. Users added to this mapping will get cluster admin access according to the groups field:
```bash
map_users = [
  {
    "userarn" : "arn:aws:iam::<AWS_ACCOUNT_ID>:user/<user1@example.com>",
    "username" : "user1@example.com",
    "groups" : ["system:masters"]
  },
...
  {
    "userarn" : "arn:aws:iam::<AWS_ACCOUNT_ID>:user/user1@example.com",
    "username" : "user1@example.com",
    "groups" : ["system:masters"]
  },
]
```

Set certificate_arn variable if you already have SSL certificate:
```bash
certificate_arn = ""
```
Set create_external_zone variable if you want the external DNS zone in Route53 to be created:
```bash
create_external_zone = <true/false>
```
Set platform_external_subdomain to variable if you want the external DNS zone in Route53 to be created:
```bash
platform_external_subdomain = "<ESK_CLUSTER_SUBDOMAIN_NAME>"
```

Set tags variable for tags to be added to the EKS cluster, worker instances and Route53 objects:
```bash
tags = {
  "SysName"      = ""
  "Environment"  = ""
  "CostCenter"   = ""
  "BusinessUnit" = ""
  "Department"   = ""
}
```

The infrastructure_public_security_group_ids variable contains security groups IDs that will be added to ALB and ELB: 
```bash
infrastructure_public_security_group_ids = [
  "sg-1",
  "sg-2", 
  ...
  "sg-3"
]
```

This module creates auto scaling group with spot instances. Following variables define an autoscaling group instance types and number:
``` bash
instance_types      = ["r5.large", "m5.xlarge", ...]
max_nodes_count     = X
desired_nodes_count = Y
demand_nodes_count  = Z
```

The infra_lb_listeners variable should contain a list of maps to be used as listeners for Classic LB (_e.g. Gerrit_). This variable should not be empty.
```bash
[
  {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  },
  ...
  {
    instance_port     = "30000"
    instance_protocol = "TCP"
    lb_port           = "30000"
    lb_protocol       = "TCP"
  }
]
```

Bastion security access can be configured via ip subnets list in the operator_cidrs variable or via security groups ids in the bastion_public_security_group_ids variable:

```bash
operator_cidrs = []

bastion_public_security_group_ids = [
  "sg-1",
  ...
  "sg-X"
]
```

#### 5. Run terraform

* Initialize remote state and download modules:
```bash
AWS_REGION=<region> AWS_PROFILE=<profile_name> terraform init -var-file terraform.tfvars
```
* Check the resource creation plan:
```bash
AWS_REGION=<region> AWS_PROFILE=<profile_name> terraform plan -var-file terraform.tfvars
```
* Review the list of resources to create and deploy infrastructure:
```bash
AWS_REGION=<region> AWS_PROFILE=<profile_name> terraform apply -var-file terraform.tfvars
```

_**NOTE**: The EKS deployment process can take about 15 minutes._

What's Next?
--------------------
It is recommended to install [ingress controller](https://kubernetes.github.io/ingress-nginx/deploy/) and [dashboard](https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html) to your EKS.