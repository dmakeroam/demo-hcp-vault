resource "aws_vpc" "main" {
  cidr_block = "10.2.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.2.1.0/24"
}