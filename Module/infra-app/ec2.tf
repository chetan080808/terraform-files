#Creating EC2 with default config and running nginx

#key pair generation
resource "aws_key_pair" "key"{
        key_name = "${var.env}-infra-key"
        public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUNrE5qgQZjVcQ+EjVroHXvOv9IBArRDnshQ/8suRhz ubuntu@DESKTOP-S9T6KIN"

    tags = {
        Environment = var.env
    }
}

#VPC generation

resource "aws_default_vpc" "default"{
        tags = {
                Name = "${var.env}-vpc"
}
}
#Security Groups generation

resource "aws_security_group" "my_sg"{
        name = "${var.env}-sg"
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
                cidr_blocks = ["0.0.0.0/0"]
                description = "Outbound Open for all"
        }

        tags = {
          Name = "${var.env}-sg"
        }
        }
#EC2 creation

resource "aws_instance" "server" {

        key_name = aws_key_pair.key.key_name
        vpc_security_group_ids = [aws_security_group.my_sg.id]

        count = var.instance_count

        instance_type = var.env == "prod" ? "t2.small" : "t2.micro"
        ami = var.ami_id


root_block_device{
        volume_size = 8
        volume_type = "gp3"

}

tags = {
        Name = "${var.env}-ec2-infra-app"
        Description = "build through terraform"
}
}
