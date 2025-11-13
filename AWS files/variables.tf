#Variables file for ec2

variable "region" {
  description = "The AWS region to create resources in"
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "The AWS availability zone to create resources in"
  default     = "us-east-1a"
}

variable "instance_type" {
  description = "The type of instance to create"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  default     = "ami-02b8269d5e85954ef"
} 

variable "ec2_block_storage_size" {
  description = "The size of the root block storage in GB"
  default     = 8
  type = number
}

variable "env" {
  default = "dev"
  description = "The environment for the infrastructure"
  type        = string
  
}