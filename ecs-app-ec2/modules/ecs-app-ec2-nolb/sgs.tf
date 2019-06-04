resource "aws_security_group" "application" {
  name        = "${local.name}"
  vpc_id      = "${var.vpc_id}"
  description = "${local.name} security group"

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${local.tags}"
}
