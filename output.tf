output "vpc_id" {
 description = "vpc id"
 value = aws_vpc.Ter_alb_vpc
}

output "subnet_1_id" {
 description = "1st subnet id"
 value = aws_subnet.Ter_alb_pubsub_1.id
}

output "subnet_2_id" {
 description = "2nd subnet id"
 value = aws_subnet.Ter_alb_pubsub_2.id
}

output "IGW_id" {
 description = "Inetrnet gateway id"
 value = aws_internet_gateway.Ter_alb_IGW.id
}

output "route_table_id" {
 description = "route table id"
 value = aws_route_table.Ter_alb_pub_rt.id
}

output "security_group_id" {
 description = "security group id"
 value = aws_security_group.Ter_alb_sg.id
}

output "keypair_id" {
 description ="keypair id"
 value = aws_key_pair.Ter_alb_keypair.id
}

output "app_1_nt_int_pri_ip" {
 description = "app 1 network interface private ip"
 value = aws_network_interface.Ter_alb_pub_int_1.private_ip
}

output "app_1_nt_int_pub_ip" {
 description = "app 1 network interface public ip"
 value = aws_eip.Ter_alb_eip_1.public_ip
}

output "app_2_nt_int_pri_ip" {
 description = "app 2 network interface private ip"
 value = aws_network_interface.Ter_alb_pub_int_2.private_ip
}

output "app_2_nt_int_pub_ip" {
 description = "app 2 network interface public ip "
 value = aws_eip.Ter_alb_eip_2.public_ip
 }

output "app_1_ec2_id" {
  description = "app 1 ec2 id"
  value = aws_instance.Ter_alb_ec2_1.id
}

output "app_2_ec2_id" {
  description = "app 2 ec2 id"
  value = aws_instance.Ter_alb_ec2_2.id
}

output "alb_arn" {
 description = "alb arn"
 value = aws_lb.Ter_alb.arn
}

output "alb_dns_name" {
 description = "aln dns name"
 value = aws_lb.Ter_alb.dns_name
}

output "alb_tg_a_arn" {
  description = "alb a tg arn"
  value = aws_lb_target_group.Ter_alb_tg_a.arn
}

output "alb_tg_b_arn" {
  description = "alb b tg arn"
  value = aws_lb_target_group.Ter_alb_tg_b.arn
}

output "alb_listener_arn" {
  description = "aws listener arn"
  value = aws_lb_listener.Ter_alb_listener.arn
}