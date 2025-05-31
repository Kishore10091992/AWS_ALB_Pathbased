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

variable "alb_ec2_key" {
  description = "SSH public key for ALB EC2"
  type        = string
  default     = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCNU3OC2E8Mkgbz/mVgn+sOR9MxDBf20QcR2ihY5C0EzaFlBX4IJ6S+ghWFQXPT21VE/a1+rcI50+ss8+6AbLapv9HqvG4zJ72l0jhXar3maI39WjaxCGb+kNzWzRHGdZd8CyTDTeU9BV3cAzkmzGnJZTJ73qZTI2oM0r/aN4qczZLmYF1yWaUq81pVoMNi/tccp6uCwd1ayE3QjgpsPBXmT9IYev05dA72EfQjLtiumdb98GTZA8mGE2qucIC5JcV4HoxCN8TmyBLcUN9Lk7XyrXo1Jfb1eCQ8roDzYjYm7wfY5f4A+rT+dpPbg29J/hNWW2bwakeDjCR2ibc/zoglmExfJewTUyunxucj5jdSGxv8D8gLGsK23YnviuFp22EqmQItDLaumHbixXyERRKlmGHVAzh6/PXl8ZGyRNSbkYTWbKLuEWKJ9TUCEo7XSDTaXAheVQABvW7CQ5qa0d3bXE2P+ke7hd0JfUxFowbb7hagZiOT8EMTKDjKQRHgm9yHjiNukqPQAVSsSWgTv6UgOIDNsgf1hVeWEfkbV1Qsr1FeePIs/cnO6Epi7ZBEMsPKLN/W1A+V2Q+m98aRJQBVKoNg9Mu3A0pWTO4cD9PLgFIMcbBcOiR1/gT5X08Opbl9/WpreL9kR4dDs3/fER8oAeLgFo2gJtABI8Nb5J+VIw== root@ip-192-168-0-88.ec2.internal
EOF
}