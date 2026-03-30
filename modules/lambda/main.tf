resource "aws_lambda_function" "private" {
  function_name = "private-lambda"
  role          = var.lambda_role_arn
  handler       = "private_lambda.lambda_handler"
  runtime       = "python3.9"
  filename      = "../../lambda-code/private_lambda.zip"

  vpc_config {
    subnet_ids         = [var.private_subnet_id]
    security_group_ids = [var.lambda_sg_id]
  }
}

resource "aws_lambda_function" "isolated" {
  function_name = "isolated-lambda"
  role          = var.lambda_role_arn
  handler       = "isolated_lambda.lambda_handler"
  runtime       = "python3.9"
  filename      = "../../lambda-code/isolated_lambda.zip"

  vpc_config {
    subnet_ids         = [var.isolated_subnet_id]
    security_group_ids = [var.lambda_sg_id]
  }
}