module "bastion" {
  source = "git::https://github.com/epmd-edp/terraform-eks-bastion?ref=0.0.1"

  vpc_id             = var.vpc_id
  key_name           = var.key_name
  platform_name      = var.platform_name
  public_subnet_id   = module.vpc.public_subnet_ids[0]
  operator_cidrs     = var.operator_cidrs
  tags               = var.tags
  security_group_ids = var.bastion_public_security_group_ids
}

module "vpc" {
  source = "git::https://github.com/epmd-edp/terraform-eks-vpc?ref=0.0.1"

  platform_name = "${lower(var.platform_name)}"

  vpc_id             = "${var.vpc_id}"
  platform_cidr      = "${var.platform_cidr}"
  private_cidrs      = "${var.private_cidrs}"
  public_cidrs       = "${var.public_cidrs}"
  public_subnet_ids  = "${var.public_subnets_id}"
  private_subnet_ids = "${var.private_subnets_id}"
  tags               = "${var.tags}"
}


module "eks" {
  source          = "git::https://github.com/epmd-edp/terraform-eks?ref=0.0.2"
  cluster_name    = var.platform_name
  vpc_id          = var.vpc_id
  subnets         = module.vpc.private_subnet_ids
  cluster_version = var.cluster_version

  manage_cluster_iam_resources = false
  cluster_iam_role_name        = var.cluster_iam_role_name
  manage_worker_iam_resources  = false

  cluster_create_security_group = false
  cluster_security_group_id     = var.cluster_security_group_id
  worker_create_security_group  = false
  worker_security_group_id      = var.worker_security_group_id
  # Uncomment the line below if you are using Windows + Git Bash
  # local_exec_interpreter = ["C:\\Program Files\\Git\\bin\\sh.exe", "-c"]

  cluster_endpoint_private_access = true

  worker_groups_launch_template = [
    {
      name                    = "${var.platform_name}-spot"
      override_instance_types = var.instance_types
      spot_instance_pools     = 1
      asg_min_size            = 1
      asg_max_size            = var.max_nodes_count
      asg_desired_capacity    = var.desired_nodes_count
      on_demand_base_capacity = var.demand_nodes_count
      kubelet_extra_args      = "--node-labels=kubernetes.io/lifecycle=spot"
      suspended_processes     = ["AZRebalance", "ReplaceUnhealthy", "Terminate"]
      public_ip               = false
      target_group_arns       = var.create_external_zone || var.platform_external_subdomain != "" ? [aws_lb_target_group.infra_http.0.arn, aws_lb_target_group.infra_https.0.arn] : []
      load_balancers          = [aws_elb.infra[0].name]
      root_volume_size        = 50
      enable_monitoring       = false

      iam_instance_profile_name = var.worker_iam_instance_profile_name
      key_name                  = var.key_name
    },
  ]

  map_users = var.map_users

  tags = var.tags
}

module "dns" {
  source = "git::https://github.com/epmd-edp/terraform-eks-dns?ref=0.0.1"

  platform_name   = lower(var.platform_name)
  platform_vpc_id = var.vpc_id

  create_external_zone        = var.create_external_zone
  platform_external_subdomain = var.platform_external_subdomain

  platform_alb_dns_name = var.create_external_zone || var.platform_external_subdomain != "" ? aws_lb.infra.0.dns_name : ""

  tags = var.tags
}

