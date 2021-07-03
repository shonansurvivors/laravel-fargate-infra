resource "aws_elasticache_subnet_group" "this" {
  name = aws_vpc.this.tags.Name

  subnet_ids = [
    for s in aws_subnet.private : s.id
  ]
}
