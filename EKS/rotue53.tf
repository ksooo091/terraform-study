resource "aws_route53_zone" "primary" {
  name = "https://${var.DOMAIN}"

}