variable "default_ip" {
 description = "default ip addressn for public connectivity"
 type = string
 default = "0.0.0.0/0"
}

variable "default_protocol" {
 description = "allow all the protocol"
 type = string
 default = "-1"
}

variable "default_port" {
 description = "allow all the port"
 type = string
 default = "0-65535"
}

variable "aws_region" {
 description = "region for infra"
 type = string
 default = "us-east-1"
}

variable "subnet_1_az" {
 description = "az for subnet 1"
 type = string
 default = "us-east-1a"
}

variable "subnet_2_az" {
 description = "az for subnet 2"
 type = string
 default = "us-east-1c"
}

variable "alb_subnet_1" {
 description = "cidr for subnet 1"
 type = string
 default = "172.168.0.0/24"
}

variable "alb_vpc" {
 description = "vpc for this infra"
 type = string
 default = "172.168.0.0/16"
}

variable "alb_subnet_2" {
 description = "cidr for subnet 2"
 type = string
 default = "172.168.1.0/24"
}

variable "user_data_1" {
 description = "user data for alb 1"
 type = string
 default = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install nginx -y
              echo "welcome to ALB-1" > /var/www/html/index.html
          EOF
}

variable "user_data_2" {
 description = "user data for alb 2"
 type = string
 default = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install nginx -y
              echo "welcome to ALB-2" > /var/www/html/index.html
          EOF
}

variable "ami_id" {
 description = "ami id instance for both ec2"
 type = string
 default = "ami-0f88e80871fd81e91"
}

variable "instance_type" {
 description = "instance type for ec2"
 type = string
 default = "t2.micro"
}

variable "loadbalancer_type" {
 description = "loadbalancer type"
 type = string
 default = "application"
}

variable "alb_internal" {
 description = "alb internal type"
 type = string
 default = "false"
}