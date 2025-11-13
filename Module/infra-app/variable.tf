#variables for infra

variable "env" {
    description = "Environment name"
    type        = string
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "instance_count" {
    description = "Number of EC2 instances to create"
    type        = number
}

variable "ami_id" {
    description = "AMI ID for the EC2 instances"
    type        = string
}
