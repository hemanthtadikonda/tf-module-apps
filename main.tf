resource "aws_security_group" "main" {
  name        = "${local.name_prefix}-sg"
  description = "${local.name_prefix}-sg"
  vpc_id      = var.vpc_id
  tags        = merge(local.tags , { Name = "${local.name_prefix}-sg"} )

  ingress {
    description      = "APP"
    from_port        = var.app_port
    to_port          = var.app_port
    protocol         = "tcp"
    cidr_blocks      = var.sg_ingress_cidr
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.ssh_ingress_cidr
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_launch_template" "main" {
  name = "${local.name_prefix}-template"
  image_id = "ami-test"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main]

  tag_specifications {
    resource_type = "instance"
    tags        = merge(local.tags , { Name = "${local.name_prefix}-template"} )
  }

  user_data = filebase64("${path.module}/example.sh")
}