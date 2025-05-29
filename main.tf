terraform {
 required_providers {
   aws = {
     source = "hashicorp/aws"
     version = "~>5.0"
   }
 }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "Ter_alb_vpc" {
  cidr_block = var.alb_vpc

  tags = {
    Name = "Ter_alb_vpc"
  }
}

resource "aws_subnet" "Ter_alb_pubsub_1" {
  vpc_id = aws_vpc.Ter_alb_vpc.id
  cidr_block = var.alb_subnet_1
  availability_zone = var.subnet_1_az

  tags = {
    Name = "Ter_alb_pubsub_1"
  }
}

resource "aws_subnet" "Ter_alb_pubsub_2" {
  vpc_id = aws_vpc.Ter_alb_vpc.id
  cidr_block = var.alb_subnet_2
  availability_zone = var.subnet_2_az

  tags = {
    Name = "Ter_alb_pubsub_2"
  }
}

resource "aws_internet_gateway" "Ter_alb_IGW" {
  vpc_id = aws_vpc.Ter_alb_vpc.id

  tags = {
    Name = "Ter_alb_IGW"
  }
}

resource "aws_route_table" "Ter_alb_pub_rt" {
  vpc_id = aws_vpc.Ter_alb_vpc.id

  route {
    cidr_block = var.default_ip
    gateway_id = aws_internet_gateway.Ter_alb_IGW.id
  }

  tags = {
    Name = "Ter_alb_pub_rt"
  }
}

resource "aws_route_table_association" "Ter_alb_pub_rt_ass_1" {
  route_table_id = aws_route_table.Ter_alb_pub_rt.id
  subnet_id = aws_subnet.Ter_alb_pubsub_1.id
}

resource "aws_route_table_association" "Ter_alb_pub_rt_ass_2" {
  route_table_id = aws_route_table.Ter_alb_pub_rt.id
  subnet_id = aws_subnet.Ter_alb_pubsub_2.id
}

resource "aws_security_group" "Ter_alb_sg" {
  vpc_id = aws_vpc.Ter_alb_vpc.id

  ingress {
    from_port = 0
    to_port = 0
    cidr_blocks = [var.default_ip]
    protocol = var.default_protocol
  }

  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = [var.default_ip]
    protocol = var.default_protocol
  }

  tags = {
    Name = "Ter_alb_sg"
  }
}

resource "aws_key_pair" "Ter_alb_keypair" {
  key_name = "Ter_alb_keypair"
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    Name = "Ter_alb_keypair"
  }
}

resource "aws_network_interface" "Ter_alb_pub_int_1" {
  subnet_id = aws_subnet.Ter_alb_pubsub_1.id
  security_groups = [aws_security_group.Ter_alb_sg.id]
}

resource "aws_eip" "Ter_alb_eip_1" {
 domain = "vpc"
 network_interface = aws_network_interface.Ter_alb_pub_int_1.id

 tags = {
  Name = "Ter_alb_eip_1"
 }
}

resource "aws_network_interface" "Ter_alb_pub_int_2" {
 subnet_id = aws_subnet.Ter_alb_pubsub_2.id
 security_groups = [aws_security_group.Ter_alb_sg.id]
}

resource "aws_eip" "Ter_alb_eip_2" {
 domain = "vpc"
 network_interface = aws_network_interface.Ter_alb_pub_int_2.id

 tags = {
  Name = "Ter_alb_eip_2"
 }
}

resource "aws_instance" "Ter_alb_ec2_1" {
 ami = var.ami_id
 instance_type = var.instance_type
 key_name = aws_key_pair.Ter_alb_keypair.key_name

 network_interface {
  device_index = 0
  network_interface_id = aws_network_interface.Ter_alb_pub_int_1.id
 }

 user_data = var.user_data_1

 tags = {
  Name = "Ter_alb_ec2_1"
 }
}

resource "aws_instance" "Ter_alb_ec2_2" {
 ami = var.ami_id
 instance_type = var.instance_type
 key_name = aws_key_pair.Ter_alb_keypair.key_name

 network_interface {
  device_index = 0
  network_interface_id = aws_network_interface.Ter_alb_pub_int_2.id
 }

 user_data = var.user_data_2

 tags = {
  Name = "Ter_alb_ec2_2"
 }
}

resource "aws_lb" "Ter_alb" {
 internal = var.alb_internal
 load_balancer_type = var.loadbalancer_type
 security_groups = [aws_security_group.Ter_alb_sg.id]
 subnets = [aws_subnet.Ter_alb_pubsub_1.id, aws_subnet.Ter_alb_pubsub_2.id]

 tags = {
  Name = "Ter_alb"
 }
}

resource "aws_lb_target_group" "Ter_alb_tg_a" {
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.Ter_alb_vpc.id

  tags = {
   Name = "Ter_alb_tg_a"
  }
}

resource "aws_lb_target_group_attachment" "Ter_alb_tg_a_att" {
 target_group_arn = aws_lb_target_group.Ter_alb_tg_a.arn
 target_id = aws_instance.Ter_alb_ec2_1.id
 port = 80
}

resource "aws_lb_target_group" "Ter_alb_tg_b" {
 port = 80
 protocol = "HTTP"
 vpc_id = aws_vpc.Ter_alb_vpc.id

 tags = {
  Name = "Ter_alb_tg_b"
 }
}

resource "aws_lb_target_group_attachment" "Ter_alb_tg_b_att" {
 target_group_arn = aws_lb_target_group.Ter_alb_tg_b.arn
 target_id = aws_instance.Ter_alb_ec2_2.id
 port = 80
}

resource "aws_lb_listener" "Ter_alb_listener" {
  port = 80
  protocol = "HTTP"
  load_balancer_arn = aws_lb.Ter_alb.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "not found"
      status_code = "404"
    }
  }
}

resource "aws_lb_listener_rule" "Ter_alb_listener_rule_1" {
  listener_arn = aws_lb_listener.Ter_alb_listener.arn
  priority = 10

  action {
    type ="forward"
    target_group_arn = aws_lb_target_group.Ter_alb_tg_a.arn
  }

  condition {
    path_pattern {
      values = ["/app1"]
    }
  }
}

resource "aws_lb_listener_rule" "Ter_alb_listener_rule_2" {
  listener_arn = aws_lb_listener.Ter_alb_listener.arn
  priority = 20

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.Ter_alb_tg_b.arn
  }

  condition {
    path_pattern {
      values = ["/app2"]
    }
  }
}