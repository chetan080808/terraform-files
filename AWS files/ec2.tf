# Creating EC2 Instance with new keypair, VPC, Subnet, Internet Gateway, Route Table, Security Group

#key pair generation
resource "aws_key_pair" "key"{
        key_name = "terra-key"
        public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUNrE5qgQZjVcQ+EjVroHXvOv9IBArRDnshQ/8suRhz ubuntu@DESKTOP-S9T6KIN"


}

#VPC generation

resource "aws_vpc" "network"{
        cidr_block = "172.32.0.0/16"
        tags = {
                Name = "my-vpc"
}
}
# Create a subnet in your VPC
resource "aws_subnet" "main_subnet"{
    vpc_id = aws_vpc.network.id
    cidr_block = "172.32.1.0/24"
    availability_zone = var.availability_zone
    map_public_ip_on_launch = true

    tags = {
        Name = "my-subnet"
    }
}

# Create Internet Gateway for internet access
resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.network.id

    tags = {
        Name = "my-igw"
    }
}

# Create route table
resource "aws_route_table" "public_rt"{
    vpc_id = aws_vpc.network.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "public-route-table"
    }
}

# Associate route table with subnet
resource "aws_route_table_association" "public_assoc"{
    subnet_id = aws_subnet.main_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

#Security Groups generation

resource "aws_security_group" "my_sg"{
        name = "new-sg-terra"
        description = "Terraform sg"
        vpc_id = aws_vpc.network.id

#inbound rules
ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "open for ssh"
}

ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "open for http"
}


#outbound rules
egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
        description = "open for all"

}
}
#EC2 creation

resource "aws_instance" "server" {

        instance_type = var.instance_type
        ami = var.ami_id
        key_name = aws_key_pair.key.key_name
        vpc_security_group_ids = [aws_security_group.my_sg.id]
        subnet_id = aws_subnet.main_subnet.id
root_block_device{
        volume_size = var.ec2_block_storage_size
        volume_type = "gp3"

}

tags = {
        Name = "automate-server"
        Description = "build through terraform"
}
}
