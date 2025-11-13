# #Output public ip and dns of ec2

output "ec2_public_ip" {
    description = "The public IP address of the EC2 instance"
    value       = aws_instance.server.public_ip
}

output "ec2_public_dns" {
    description = "The public DNS of the EC2 instance"
    value       = aws_instance.server.public_dns
}

#outout for count---------------------------------------------------

output "ec2_public_ip" {
    description = "The public IP address of the EC2 instance"
    value       = aws_instance.server[*].public_ip
}

output "ec2_public_dns" {
    description = "The public DNS of the EC2 instance"
    value       = aws_instance.server[*].public_dns
}

#outout for For Each ------------------------------------------

output "ec2_instances_info" {
  description = "Information about all EC2 instances"
  value = {
    for instance in aws_instance.server :
    instance.id => {
      public_ip  = instance.public_ip
      public_dns = instance.public_dns
    }
  }
}