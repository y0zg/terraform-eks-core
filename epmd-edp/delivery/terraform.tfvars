region = "eu-central-1"

platform_name = "eks-delivery"

vpc_id = "vpc-0c94decb1fb748547"

private_subnets_id = [
  "subnet-0ab8d557add4492e4",
  "subnet-061ce671b45bc41fb",
  "subnet-03fc221161dd07725",
]

public_subnets_id = [
  "subnet-0dbf44925da282b11",
  "subnet-058e5ed174faace10",
  "subnet-0a45827f21a4fd6f9",
]

cluster_version = "1.14"

cluster_security_group_id = "sg-0d1408d2c0f70e415"

worker_security_group_id = "sg-0d1408d2c0f70e415"

infra_public_security_group_ids = [
  "sg-0d1408d2c0f70e415"
]

cluster_iam_role_name = "AWSServiceRoleC1517100"

worker_iam_instance_profile_name = "AmazonEksWorkerNode"

key_name = "epmd-edp"

map_users = [
  {
    "userarn" : "arn:aws:iam::093899590031:user/alexander_morozov@epam.com",
    "username" : "alexander_morozov@epam.com",
    "groups" : ["system:masters"]
  },
  {
    "userarn" : "arn:aws:iam::093899590031:user/viktor_voronin@epam.com",
    "username" : "viktor_voronin@epam.com",
    "groups" : ["system:masters"]
  },
  {
    "userarn" : "arn:aws:iam::093899590031:user/iryna_mikhieieva@epam.com",
    "username" : "iryna_mikhieieva@epam.com",
    "groups" : ["system:masters"]
  },
  {
    "userarn" : "arn:aws:iam::093899590031:user/pavlo_yemelianov@epam.com",
    "username" : "pavlo_yemelianov@epam.com",
    "groups" : ["system:masters"]
  },
  {
    "userarn" : "arn:aws:iam::093899590031:user/stanislav_kostenko@epam.com",
    "username" : "stanislav_kostenko@epam.com",
    "groups" : ["system:masters"]
  },
  {
    "userarn" : "arn:aws:iam::093899590031:user/anton_tarianyk@epam.com",
    "username" : "anton_tarianyk@epam.com",
    "groups" : ["system:masters"]
  },
  {
    "userarn" : "arn:aws:iam::093899590031:user/serhii_shydlovskyi@epam.com",
    "username" : "serhii_shydlovskyi@epam.com",
    "groups" : ["system:masters"]
  }
]

certificate_arn = ""

create_external_zone        = false
platform_external_subdomain = "aws.main.edp.projects.epam.com"

tags = {
  "SysName"      = "EPAM"
  "SysOwner"     = "SpecialEPMD-EDPcoreteam@epam.com"
  "Environment"  = "EKS-DELIVERY-CLUSTER"
  "CostCenter"   = "1111"
  "BusinessUnit" = "EDP"
  "Department"   = "EPMD-EDP"
}

# bastion

operator_cidrs = []

public_subnet_id = "subnet-0dbf44925da282b11"

bastion_public_security_group_ids = [                      
  "sg-053456cbb80288d78", //EPAM BY-RU
  "sg-06991eda49323a359", //EPAM Europe
  "sg-0d1408d2c0f70e415", //Default
  "sg-0d5e8f43bb0e35330", //EPAM Global
]
