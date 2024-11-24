locals {
  ingress_rules = [
    {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
    },
    {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
    },
    {
      from_port = 4000
      to_port   = 4000
      protocol  = "tcp"
    },
    {
      from_port = 8080
      to_port   = 8080
      protocol  = "tcp"
    },
    {
      from_port = 9000
      to_port   = 9000
      protocol  = "tcp"
    },
    {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"
    },
  ]
}

resource "aws_security_group" "example" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id
  tags = {
    Name = "MySecurityGroup" # You can replace "MySecurityGroup" with your desired tag value

  }

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
