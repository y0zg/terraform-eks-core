region = ""
platform_name = ""
vpc_id = ""

private_subnets_id = []
public_subnets_id = []

cluster_version = "1.14"
cluster_security_group_id = ""
worker_security_group_id = ""
infra_public_security_group_ids = []

cluster_iam_role_name = ""
worker_iam_instance_profile_name = ""

key_name = ""

map_users = [
  {
    "userarn" : "arn:aws:iam::",
    "username" : ""
    "groups" : ["system:masters"]
  },
]

certificate_arn = ""

create_external_zone        = false
platform_external_subdomain = ""

tags = {
}

# bastion
# operator_cidrs = []
# public_subnet_id = ""
infra_lb_listeners = []
