output "vpc_id" {
  value = aws_vpc.basic_vpc.id
}

output "subnet_a_id" {
  value = aws_subnet.public_a.id
}

output "subnet_b_id" {
  value = aws_subnet.public_b.id
}