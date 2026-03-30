output "public_api_url" {
  value = module.apigateway.public_api_url
}

output "s3_bucket" {
  value = module.s3.bucket_name
}