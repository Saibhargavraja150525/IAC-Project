output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "web_public_ip" {
  description = "Public IP of the web server"
  value       = aws_instance.web.public_ip
}

output "website_url" {
  description = "URL to test the web server"
  value       = "http://${aws_instance.web.public_ip}"
}

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.artifacts.bucket
}
