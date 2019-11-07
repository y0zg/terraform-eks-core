data "aws_route53_zone" "public" {
  count        = var.create_external_zone || var.platform_external_subdomain != "" ? 1 : 0
  name         = var.platform_external_subdomain
  private_zone = false
}

resource "aws_acm_certificate" "eks-cluster" {
  count       = var.certificate_arn == "" && (var.create_external_zone || var.platform_external_subdomain != "") ? 1 : 0
  domain_name = var.platform_external_subdomain

  subject_alternative_names = [
    "*.${var.platform_name}.${var.platform_external_subdomain}"
  ]

  validation_method = "DNS"

  tags = merge(var.tags, map("Name", format("%s", var.platform_name)))
}

resource "aws_route53_record" "eks-cluster_cert-verification" {
  count           = var.certificate_arn == "" && (var.create_external_zone || var.platform_external_subdomain != "") ? 2 : 0
  name            = lookup(element(aws_acm_certificate.eks-cluster.*.domain_validation_options, 0)[count.index], "resource_record_name")
  type            = lookup(element(aws_acm_certificate.eks-cluster.*.domain_validation_options, 0)[count.index], "resource_record_type")
  zone_id         = data.aws_route53_zone.public.0.zone_id
  records         = [lookup(element(aws_acm_certificate.eks-cluster.*.domain_validation_options, 0)[count.index], "resource_record_value")]
  ttl             = 300
  allow_overwrite = true
}


resource "aws_acm_certificate_validation" "eks-cluster" {
  count           = var.certificate_arn == "" && (var.create_external_zone || var.platform_external_subdomain != "") ? 1 : 0
  certificate_arn = aws_acm_certificate.eks-cluster.0.arn

  validation_record_fqdns = aws_route53_record.eks-cluster_cert-verification.*.fqdn

  timeouts {
    create = "2h"
  }
}
