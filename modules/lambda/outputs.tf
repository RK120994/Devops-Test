output "private_lambda_arn" {
  value = aws_lambda_function.private.arn
}

output "isolated_lambda_arn" {
  value = aws_lambda_function.isolated.arn
}