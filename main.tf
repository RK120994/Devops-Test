#####################################
# IAM ROLE FOR LAMBDA
#####################################
resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# CloudWatch logging
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Required for VPC access (VERY important in your setup)
resource "aws_iam_role_policy_attachment" "lambda_vpc_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

#####################################
# MODULES
#####################################

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "s3" {
  source = "./modules/s3"
}

module "lambda" {
  source = "./modules/lambda"

  private_subnet_id  = module.vpc.private_subnet_id
  isolated_subnet_id = module.vpc.isolated_subnet_id
  lambda_sg_id       = module.vpc.lambda_sg_id
  s3_bucket_name     = module.s3.bucket_name

  # ✅ FIX: pass IAM role into module
  lambda_role_arn = aws_iam_role.lambda_role.arn
}

module "apigateway" {
  source = "./modules/apigateway"

  private_lambda_arn  = module.lambda.private_lambda_arn
  isolated_lambda_arn = module.lambda.isolated_lambda_arn
}

module "waf" {
  source = "./modules/waf"

  api_arn = module.apigateway.public_api_arn
}

#####################################
# VPC ENDPOINT FOR S3 (no NAT needed)
#####################################
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.region}.s3"

  route_table_ids = [
    module.vpc.private_route_table_id,
    module.vpc.isolated_route_table_id
  ]
}