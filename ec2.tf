# Find the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# Create EC2 Instance
resource "aws_instance" "deepseek_r1" {
  ami                  = data.aws_ami.amazon_linux_2.id
  instance_type        = "g4dn.xlarge"
  iam_instance_profile = aws_iam_instance_profile.deepseek_r1_instance_profile.name
  subnet_id            = aws_subnet.public[0].id

  root_block_device {
    volume_size = 100
    volume_type = "gp3"
  }

  vpc_security_group_ids = [aws_security_group.deepseek_sg.id]

  tags = {
    Name = "deepseek-r1"
  }

  # User data to install NVIDIA drivers, Docker and Ollama
  user_data = base64encode(file("${path.module}/scripts/setup_ollama.sh"))

}
