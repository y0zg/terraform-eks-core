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

variable "infra_public_security_group_ids" {
  description = "Security group IDs should be attached to external ALB"
  type        = list
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
# variable "public_subnet_id" {
#   default = "Public subnet id in with to deploy bastion host"
#   type    = string
# }
#
# variable "operator_cidrs" {
#   description = "The CIDR blocks from which bastion host can be accessed"
#   type        = list
# }
