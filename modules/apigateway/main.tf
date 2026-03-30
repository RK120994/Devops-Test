resource "aws_apigatewayv2_api" "public" {
  name          = "public-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_api" "private" {
  name          = "private-api"
  protocol_type = "HTTP"
}