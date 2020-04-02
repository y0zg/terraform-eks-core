region = "eu-central-1"

platform_name = "eks-delivery"
vpc_id        = "vpc-0c94decb1fb748547"
platform_cidr = "10.72.0.0/16"

private_subnets_id = []
private_cidrs      = ["10.72.0.0/22", "10.72.4.0/22", "10.72.8.0/22"]

public_subnets_id = []
public_cidrs      = ["10.72.12.0/22", "10.72.16.0/22", "10.72.20.0/22"]

cluster_version           = "1.14"
cluster_security_group_id = "sg-0d1408d2c0f70e415"
worker_security_group_id  = "sg-0d1408d2c0f70e415"

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
  },
  {
    "userarn" : "arn:aws:iam::093899590031:user/roman_kovtun@epam.com",
    "username" : "roman_kovtun@epam.com",
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
  "user:tag"     = "EDP-delivery-eks"
}

operator_cidrs = []

bastion_public_security_group_ids = [
  "sg-053456cbb80288d78", //EPAM BY-RU
  "sg-06991eda49323a359", //EPAM Europe
  "sg-0d1408d2c0f70e415", //Default
  "sg-0d5e8f43bb0e35330", //EPAM Global
]

infrastructure_public_security_group_ids = [
  "sg-05d883695dad183e5",
  "sg-053456cbb80288d78", //EPAM BY-RU
  "sg-06991eda49323a359", //EPAM Europe
  "sg-0d1408d2c0f70e415", //Default
  "sg-0d5e8f43bb0e35330", //EPAM Global
]

// Variables for spot pool
instance_types      = ["r5.large"]
max_nodes_count     = 6
desired_nodes_count = 6
demand_nodes_count  = 6

infra_lb_listeners = [ // List of maps for using as listners foc Classic LB, Gerrit for example. Can't be empty
  {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  },
  {
    instance_port     = "30000"
    instance_protocol = "TCP"
    lb_port           = "30000"
    lb_protocol       = "TCP"
  }
]