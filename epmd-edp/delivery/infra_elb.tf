resource "aws_elb" "infra" {
  count    = var.create_external_zone || var.platform_external_subdomain != "" ? 1 : 0
  name     = format("%s-infra-external", var.platform_name)
  internal = false
  subnets  = module.vpc.public_subnet_ids

  security_groups = var.infrastructure_public_security_group_ids

  tags = "${merge(var.tags, map("Name", "${var.platform_name}-infra-external"))}"

  dynamic "listener" {
    for_each = var.infra_lb_listeners
    content {
      instance_port     = listener.value.instance_port
      instance_protocol = listener.value.instance_protocol
      lb_port           = listener.value.lb_port
      lb_protocol       = listener.value.lb_protocol
    }
  }

  listener {
    instance_port      = 443
    instance_protocol  = "https"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = coalesce(var.certificate_arn, join("", aws_acm_certificate_validation.eks-cluster.*.certificate_arn))
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "TCP:22"
    interval            = 30
  }
}
