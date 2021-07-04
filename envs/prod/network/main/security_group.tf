resource "aws_security_group" "web" {
  name   = "${aws_vpc.this.tags.Name}-web"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${aws_vpc.this.tags.Name}-web"
  }
}

resource "aws_security_group" "vpc" {
  name   = "${aws_vpc.this.tags.Name}-vpc"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${aws_vpc.this.tags.Name}-vpc"
  }
}

resource "aws_security_group" "db_foobar" {
  name   = "${aws_vpc.this.tags.Name}-db-foobar"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${aws_vpc.this.tags.Name}-db-foobar"
  }
}

resource "aws_security_group" "cache_foobar" {
  name   = "${aws_vpc.this.tags.Name}-cache-foobar"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${aws_vpc.this.tags.Name}-cache-foobar"
  }
}
