resource "aws_instance" "example_instance" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t3.micro"

}