variable "region" {
  description = "The AWS region to deploy the cluster into (e.g. eu-central-1)"
  type        = "string"
}

variable "platform_name" {
  description = "The name of the cluster that is used for tagging resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC id in which we deploy EKS cluster"
  type        = string
}

variable "private_subnets_id" {
  description = "A list of subnets to place the EKS cluster and workers within"
  type        = list
}

variable "public_subnets_id" {
  description = "A list of subnets to place the LB and other external resources"
  type        = list
}

variable "infrastructure_public_security_group_ids" {
  description = "Security groups to be attached to infrastructure LB and external ALB."
  type        = list
}

variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.14"
}

variable "cluster_security_group_id" {
  description = "A security group ID to run EKS cluster and workers"
  type        = string
}

variable "worker_security_group_id" {
  description = "A security group ID to run EKS cluster and workers"
  type        = string
}

variable "cluster_iam_role_name" {
  description = "A cluster IAM role name (not ARN) to run EKS cluster"
  type        = string
}

variable "worker_iam_instance_profile_name" {
  description = "An instance profile name (not ARN) to run EKS worker nodes"
  type        = string
}

variable "key_name" {
  description = "The name of AWS ssh key to create and attach to all created nodes"
  type        = string
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap"
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "create_external_zone" {
  description = "Boolean variable which defines weather external zone will be created or existing will be used"
  type        = bool
  default     = false
}

variable "platform_external_subdomain" {
  description = "The name of existing or to be created(depends on create_external_zone variable) external DNS zone"
  type        = string
  default     = ""
}

variable certificate_arn {
  description = "The ARN of the existing SSL certificate"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map
}

# bastion needs
#
// Security groups to be attached to Bastion instance. Leave empty you'd like to create them during provisioning
variable "bastion_public_security_group_ids" {
  description = "Security groups to be attached to Bastion instance. Leave empty you'd like to create them during provisioning"
  type        = list
}

// CIDR blocks to be added to bastion security group if created
variable "operator_cidrs" {
  description = "The CIDR blocks from which bastion host can be accessed"
  type        = list
}

variable "platform_cidr" {
  description = "CIRD of your future or existing VPC"
  type        = "string"
}

variable "private_cidrs" {
  description = "CIRD of your future or existing VPC"
  type        = "list"
  default     = []
}

variable "public_cidrs" {
  description = "CIRD of your future or existing VPC"
  type        = "list"
  default     = []
}

// Variables for spot pool
variable "instance_types" {
  description = "AWS instance type to build nodes"
  type        = "list"
  default     = ["r5.large"]
}

variable "max_nodes_count" {
  description = "Maximum nodes count in ASG"
  default     = 3
}

variable "desired_nodes_count" {
  description = "Desired nodes count in ASG"
  default     = 3
}

variable "demand_nodes_count" {
  description = "On-demand nodes count in ASG" // Must be less or equal to desired_nodes_count
  default     = 3
}

variable infra_lb_listeners {
  type        = "list"
  description = "List of maps for using as listners for Classic LB"
}