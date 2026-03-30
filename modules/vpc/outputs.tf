output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "isolated_subnet_id" {
  value = aws_subnet.isolated.id
}

output "lambda_sg_id" {
  value = aws_security_group.lambda_sg.id
}

output "private_route_table_id" {
  value = aws_route_table.private_rt.id
}

output "isolated_route_table_id" {
  value = aws_route_table.isolated_rt.id
}