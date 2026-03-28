data "aws_ami" "ubuntu" {
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*amd64*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_key_pair" "deployer" {
    key_name="bankapp-automate-key"
    public_key=file("bankapp-automate-key.pub")
} 

# VPC Default

resource "aws_default_vpc" "default" {
}

resource aws_security_group my_security_group {

name="bankapp-security"
vpc_id= aws_default_vpc.default.id  # interpolation
description = "this is Inbound and outbound rules for your instance Security group"

}

# Inbound & Outbount port rules

resource aws_vpc_security_group_ingress_rule allow_http {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource aws_vpc_security_group_ingress_rule allow_ssh {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource aws_vpc_security_group_ingress_rule allow_https {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource aws_vpc_security_group_egress_rule allow_all_traffic {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


# EC2 instance

resource "aws_instance" "testinstance" {

	ami = data.aws_ami.ubuntu.id  # OS AMI ID

	instance_type = var.instance_type # Instance Type

	key_name = aws_key_pair.deployer.key_name	# Key pair

	vpc_security_group_ids = [aws_security_group.my_security_group.id]# VPC & Security Group

    tags = {
        Name = "bankapp-automation-server"
    }
	
	# root storage (EBS)
	root_block_device {
		volume_size = 30
		volume_type = "gp3"
	}

}