resource "aws_s3_bucket" "bucket" {
    bucket = var.bucket_name

    tags = {
      Name = "Skillfied Project Bucket"
    }
}

resource "aws_s3_bucket_versioning" "versioning" {
    bucket = aws_s3_bucket.bucket.id

    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_object" "sample_file" {
    bucket = aws_s3_bucket.bucket.id
    key = "sample.txt"
    source = "${path.module}/../../files/sample.txt"
    
}

