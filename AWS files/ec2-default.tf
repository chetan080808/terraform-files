#Creating EC2 with default config and running nginx

#key pair generation
resource "aws_key_pair" "key"{
        key_name = "terra-key"
        public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUNrE5qgQZjVcQ+EjVroHXvOv9IBArRDnshQ/8suRhz ubuntu@DESKTOP-S9T6KIN"


}

#VPC generation

resource "aws_default_vpc" "default"{
        tags = {
                Name = "my-vpc"
}
}
#Security Groups generation

resource "aws_default_security_group" "my_sg"{
        vpc_id = aws_default_vpc.default.id

        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                description = "SSH access"

}
        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                description = "HTTP access"
                }
        
        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                description = "Outbound Open for all"
        }
        }
#EC2 creation

resource "aws_instance" "server" {

        region = var.region
        availability_zone = var.availability_zone

        key_name = aws_key_pair.key.key_name
        vpc_security_group_ids = [aws_default_security_group.my_sg.id]

        for_each = tomap({
          "instance1" = "Automated 1"
          "instance2" = "Automated 2"
        })
        
        instance_type = var.instance_type
        ami = var.ami_id
        user_data = file("install_nginx.sh")

root_block_device{
        volume_size = var.ec2_block_storage_size
        volume_type = "gp3"

}

tags = {
        Name = each.value
        Description = "build through terraform"
}
}

#import ec2 instance
#terraform import aws_instance.server i-0123456789abcdef0

resource "aws_instance" "existing_server"  {
        ami  = "ami-02b8269d5e85954ef"
        instance_type = "t2.micro"

lifecycle {
    prevent_destroy = true
    ignore_changes  = [ami, user_data]
}
}

