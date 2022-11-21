module "node_js_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "~>4.16.1"
  name        = "demo-nodejs-sg"
  description = "Security group for demo-nodejs"
  vpc_id      = aws_vpc.main.id
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH Allow"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 9000
      to_port     = 9000
      protocol    = "tcp"
      description = "Node.js Allow"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "Allow All"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

resource "aws_key_pair" "demo_nodejs_key" {
  key_name   = "demo-nodejs-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAIUS2sfVM4VLaiZ4mOVKBN9ETfwH94RbXn14TW3Ncg0EjVlUqxLID8K6d7qWtXqCc+1PUGwKA6XD7rKZFDBAHoiwfy77bQdofe2IQ/FwdZXW7UDF4mzYL3Mywt2xJsIlSbvA3Djw/NmEgY2a0JRO5xKnbaNltbHtGApYQPxUqJQy8/EUHOy6gXj7PIg/05I6JduuCJqrczil8x6QARH7z5v6u9QAlEVImFQrG7of+xf6NIRN8Vay2jQf1iRqQewRzVoX48f6uaL2qQlXf3v+U2vC4FI4MHpztHuYEcwf2L7KGzYeK+yFKrQaQcHCAYt02SxyyoHAL0VCJ7btwAgOYPl5jXvHbatf1OsjnaGUOriENvVvlWXV/nY9vw6iHPf7GaI3DSlo8K2P0XC4xXebMwyOV1rk85EeSTLQqAmxWD3BjB+Jj3lukEVpyQxfxSwEjW4zJl4x7GJSbqi4R6DZPbtnzjkFTetCY4UeprTmhf6M4hjVHLPRBijSdINuqL5k= sirinatpaphatsirinatthi@Sirinats-MacBook-Pro.local"
}

module "ec2_instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "~>4.2.0"
  name                        = "demo-nodejs"
  ami                         = "ami-0d593311db5abb72b"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.demo_nodejs_key.key_name
  monitoring                  = true
  vpc_security_group_ids      = [module.node_js_sg.security_group_id]
  subnet_id                   = aws_subnet.main.id
  availability_zone           = "us-west-2d"
  associate_public_ip_address = true
}