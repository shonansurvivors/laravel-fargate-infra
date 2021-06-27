resource "aws_db_subnet_group" "this" {
  name = aws_vpc.this.tags.Name

  subnet_ids = [
    for s in aws_subnet.private : s.id
  ]

  tags = {
    Name = aws_vpc.this.tags.Name
  }
}
