output "security_group_web_id" {
  value = aws_security_group.web.id
}

output "security_group_vpc_id" {
  value = aws_security_group.vpc.id
}

output "subnet_public" {
  value = aws_subnet.public
}

output "subnet_private" {
  value = aws_subnet.private
}

output "vpc_this_id" {
  value = aws_vpc.this.id
}
