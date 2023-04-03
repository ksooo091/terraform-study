resource "aws_acm_certificate" "cert_wildCard" {
  domain_name       = "*.${var.DOMAIN}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "cert_non_wildCard" {
  domain_name       = var.DOMAIN
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}