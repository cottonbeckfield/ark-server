provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
}

data "aws_ami" "ubuntu-20_04" {
    most_recent = true
    owners = ["099720109477"] # Canonical

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "ark_ports" {
  name        = "ark-ports"
  vpc_id = aws_default_vpc.default.id
  description = "All ports for serving Ark: Surival Evolved"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH Access"
  }

  ingress {
    from_port   = 7777
    to_port     = 7778
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Game client port and raw udp socket port"
  }

  ingress {
    from_port   = 7777
    to_port     = 7778
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Game client port and raw udp socket port"
  }

  ingress {
    from_port   = 27015
    to_port     = 27015
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Query port for Steams server browser"
  }

  ingress {
    from_port   = 27020
    to_port     = 27020
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "RCON for remote console server access"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ark-server" {
    ami           = data.aws_ami.ubuntu-20_04.id
    instance_type = "t2.large"
    key_name      = var.key_name
    vpc_security_group_ids = [aws_security_group.ark_ports.id]
    associate_public_ip_address = true

    ebs_block_device {
      device_name = "/dev/sdb"
      volume_type = "gp3"
      volume_size = "50"
      delete_on_termination = true
    }

    tags = {
      Appliation = "ark",
      OS = "UBUNTU"
    }
}

output "image_id" {
    value = data.aws_ami.ubuntu-20_04.id
}
