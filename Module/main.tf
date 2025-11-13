module "dev-infra" {
  source = "./terra-app"

    env = "dev"
    bucket_name = "my-infra-app13112025"

    instance_count = 1
    ami_id = "ami-03695d52f0d883f65"  # Example AMI ID for ubunut

}

module "stg-infra" {
  source = "./terra-app"

    env = "stg"
    bucket_name = "my-infra-app13112025"

    instance_count = 1
    ami_id = "ami-03695d52f0d883f65"  # Example AMI ID for ubunut

}

module "prod-infra" {
  source = "./terra-app"

    env = "prod"
    bucket_name = "my-infra-app13112025"

    instance_count = 1
    ami_id = "ami-03695d52f0d883f65"  # Example AMI ID for ubunut

}
