region = "eu-central-1"

platform_name = "eks-demo"
vpc_id        = "vpc-053a2853a6b2649da"
platform_cidr = "172.32.0.0/16"

private_subnets_id = []
private_cidrs      = ["172.32.0.0/22", "172.32.4.0/22", "172.32.8.0/22"]

public_subnets_id = []
public_cidrs      = ["172.32.12.0/22", "172.32.16.0/22", "172.32.20.0/22"]

cluster_version           = "1.14"
cluster_security_group_id = "sg-0fa1cd0e1467b5341"
worker_security_group_id  = "sg-0fa1cd0e1467b5341"

infra_public_security_group_ids = [
  "sg-0fa1cd0e1467b5341"
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
  "Environment"  = "EKS-DEMO-CLUSTER"
  "CostCenter"   = "1111"
  "BusinessUnit" = "EDP"
  "Department"   = "EPMD-EDP"
  "user:tag"     = "EDP-demo-eks"
}

operator_cidrs = []

bastion_public_security_group_ids = [
  "sg-0e2db7d9ed6be620d", //EPAM BY-RU
  "sg-013a833330996f967", //EPAM Europe
  "sg-0fa1cd0e1467b5341", //Default
  "sg-06f5cdefc3d2df31e", //EPAM Global
]

infrastructure_public_security_group_ids = [
  //"sg-05d883695dad183e5",
  "sg-09f616ddece6e119d",
  "sg-0e2db7d9ed6be620d", //EPAM BY-RU
  "sg-013a833330996f967", //EPAM Europe
  "sg-0fa1cd0e1467b5341", //Default
  "sg-06f5cdefc3d2df31e", //EPAM Global
]


// Variables for spot pool
instance_types      = ["r5.large"]
max_nodes_count     = 3
desired_nodes_count = 3
demand_nodes_count  = 3

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
