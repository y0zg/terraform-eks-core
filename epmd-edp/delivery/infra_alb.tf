resource "aws_lb" "infra" {
  count                            = var.create_external_zone || var.platform_external_subdomain != "" ? 1 : 0
  name                             = format("%s-infra-alb", var.platform_name)
  internal                         = false
  subnets                          = module.vpc.public_subnet_ids
  load_balancer_type               = "application"
  enable_cross_zone_load_balancing = true

  security_groups = var.infrastructure_public_security_group_ids

  tags = merge(var.tags, map("Name", format("%s-infra", var.platform_name)), map("Application", "any"), map("Role", "infra"))
}

resource "aws_lb_listener" "infra_http" {
  count             = var.create_external_zone || var.platform_external_subdomain != "" ? 1 : 0
  load_balancer_arn = aws_lb.infra[count.index].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.infra_http[count.index].arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "infra_https" {
  count             = var.create_external_zone || var.platform_external_subdomain != "" ? 1 : 0
  load_balancer_arn = aws_lb.infra[count.index].arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = coalesce(var.certificate_arn, join("", aws_acm_certificate_validation.eks-cluster.*.certificate_arn))

  default_action {
    target_group_arn = aws_lb_target_group.infra_https[count.index].arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "infra_http" {
  count                = var.create_external_zone || var.platform_external_subdomain != "" ? 1 : 0
  name                 = format("%s-infra-alb-http", var.platform_name)
  port                 = 32080
  protocol             = "HTTP"
  deregistration_delay = 20
  vpc_id               = var.vpc_id
  tags                 = merge(var.tags, map("Name", format("%s-infra", var.platform_name)))
}

resource "aws_lb_target_group" "infra_https" {
  count                = var.create_external_zone || var.platform_external_subdomain != "" ? 1 : 0
  name                 = format("%s-infra-alb-https", var.platform_name)
  port                 = 32443
  protocol             = "HTTPS"
  deregistration_delay = 20
  vpc_id               = var.vpc_id
  tags                 = merge(var.tags, map("Name", format("%s-infra", var.platform_name)))
}
