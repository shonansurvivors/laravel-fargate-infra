resource "aws_eip" "nat_gateway" {
  for_each = var.enable_nat_gateway ? local.nat_gateway_azs : {}

  vpc = true

  tags = {
    Name = "${aws_vpc.this.tags.Name}-nat-gateway-${each.key}"
  }
}
