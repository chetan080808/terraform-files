#code for s3 bucket creation

resource "aws_s3_bucket" "storage"{
        bucket = "${var.env}-${var.bucket_name}"
        tags = {
                Name = "${var.env}-${var.bucket_name}"
                Environment = var.env
        }



}