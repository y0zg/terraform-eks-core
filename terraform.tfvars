region = "eu-central-1"

platform_name = "core-platform"

vpc_id = "vpc-0b1047b2711892e06"

private_subnets_id = [
  "subnet-0ddf4d8b11154e5ba",
  "subnet-05f33489bd93e0576",
  "subnet-02537d12c18e7f83f",
]

public_subnets_id = [
  "subnet-07ee719ffb554e759",
  "subnet-0e2ec3ce3e54a1cc8",
  "subnet-07b8b9f4472636428",
]

cluster_version = "1.14"

cluster_security_group_id = "sg-0c0c7bd6715a23779"

worker_security_group_id = "sg-0c0c7bd6715a23779"

infra_public_security_group_ids = [
  "sg-0c0c7bd6715a23779"
]

cluster_iam_role_name = "AWSServiceRoleEKSCluster_C1528134"

worker_iam_instance_profile_name = "AWSServiceRoleEKSWorkerNode_C1528134"

key_name = "synt-dots"

map_users = [
  {
    "userarn" : "arn:aws:iam::556969431317:user/ihor_kalyniak@epam.com",
    "username" : "ihor_kalyniak@epam.com",
    "groups" : ["system:masters"]
  },
  {
    "userarn" : "arn:aws:iam::556969431317:user/ivan_brovkin@epam.com",
    "username" : "ivan_brovkin@epam.com",
    "groups" : ["system:masters"]
  },
  {
    "userarn" : "arn:aws:iam::556969431317:user/maksim_titov2@epam.com",
    "username" : "maksim_titov2@epam.com",
    "groups" : ["system:masters"]
  },
  {
    "userarn" : "arn:aws:iam::556969431317:user/mykola_marusenko@epam.com",
    "username" : "mykola_marusenko@epam.com",
    "groups" : ["system:masters"]
  },
  {
    "userarn" : "arn:aws:iam::556969431317:user/olha_besedina@epam.com",
    "username" : "olha_besedina@epam.com",
    "groups" : ["system:masters"]
  },
  {
    "userarn" : "arn:aws:iam::556969431317:user/roman_kovtun@epam.com",
    "username" : "roman_kovtun@epam.com",
    "groups" : ["system:masters"]
  },
  {
    "userarn" : "arn:aws:iam::556969431317:user/sergiy_kulanov@epam.com",
    "username" : "sergiy_kulanov@epam.com",
    "groups" : ["system:masters"]
  }
]

certificate_arn = ""

create_external_zone        = false
platform_external_subdomain = "synt-dots.com"

tags = {
  "SysName"      = "CORE-PLATFORM"
  "SysOwner"     = "SYNT-DOTS"
  "Environment"  = "DEV"
  "CostCenter"   = "1111"
  "BusinessUnit" = "RnD"
  "Department"   = "Research Management and Operations"
}

# bastion
# operator_cidrs = ["178.150.132.209/32"]

# public_subnet_id = "subnet-07ee719ffb554e759"
