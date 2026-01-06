output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "asg_name" {
  value = aws_autoscaling_group.asg.name
}
