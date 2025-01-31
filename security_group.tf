

# Create Security Group for EC2 Instance
resource "aws_security_group" "deepseek_sg" {
  name        = "deepseek-sg"
  description = "Allow HTTP traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
