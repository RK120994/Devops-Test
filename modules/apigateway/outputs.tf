output "public_api_url" {
  value = aws_apigatewayv2_api.public.api_endpoint
}

output "public_api_arn" {
  value = aws_apigatewayv2_api.public.arn
}