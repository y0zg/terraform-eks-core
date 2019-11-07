 module "bastion" {
   source = "git::https://gerrit-edp-cicd-delivery.delivery.aws.main.edp.projects.epam.com/terraform-eks-bastion?ref=0.0.1"

   vpc_id           = var.vpc_id
   key_name         = var.key_name
   platform_name    = var.platform_name
   public_subnet_id = var.public_subnet_id
   operator_cidrs   = var.operator_cidrs
   tags             = var.tags
   security_group_ids = var.bastion_public_security_group_ids
 }

module "eks" {
  source          = "git::https://gerrit-edp-cicd-delivery.delivery.aws.main.edp.projects.epam.com/terraform-eks?ref=0.0.1"
  cluster_name    = var.platform_name
  vpc_id          = var.vpc_id
  subnets         = var.private_subnets_id
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
      name                    = "eks-delivery-spot"
      override_instance_types = ["r5.large"]
      spot_instance_pools     = 1
      asg_min_size            = 1
      asg_max_size            = 3
      asg_desired_capacity    = 3
      kubelet_extra_args      = "--node-labels=kubernetes.io/lifecycle=spot"
      public_ip               = false
      target_group_arns       = var.create_external_zone || var.platform_external_subdomain != "" ? [aws_lb_target_group.infra_http.0.arn, aws_lb_target_group.infra_https.0.arn] : []

      root_volume_size  = 50
      enable_monitoring = false

      iam_instance_profile_name = var.worker_iam_instance_profile_name
      key_name                  = var.key_name
    },
  ]

  map_users = var.map_users

  tags = var.tags
}

module "dns" {
  source = "git::https://gerrit-edp-cicd-delivery.delivery.aws.main.edp.projects.epam.com/terraform-eks-dns?ref=0.0.1"

  platform_name   = lower(var.platform_name)
  platform_vpc_id = var.vpc_id

  create_external_zone        = var.create_external_zone
  platform_external_subdomain = var.platform_external_subdomain

  platform_alb_dns_name = var.create_external_zone || var.platform_external_subdomain != "" ? aws_lb.infra.0.dns_name : ""

  tags = var.tags
}

