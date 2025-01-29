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
    ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "g4dn.xlarge"
  iam_instance_profile = aws_iam_instance_profile.deepseek_r1_instance_profile.name

  root_block_device {
    volume_size = 100
    volume_type = "gp3"
  }

  vpc_security_group_ids = [aws_security_group.deepseek_sg.id]

  tags = {
    Name = "deepseek-r1"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y gcc make kernel-devel-$(uname -r)
              cd ~
              aws s3 cp --recursive s3://ec2-linux-nvidia-drivers/latest/ .
              chmod +x NVIDIA-Linux-x86_64*.run
              mkdir /home/ssm-user/tmp
              chmod -R 777 tmp
              cd /home/ssm-user
              export TMPDIR=/home/ssm-user/tmp
              CC=/usr/bin/gcc10-cc ./NVIDIA-Linux-x86_64*.run --tmpdir=$TMPDIR
              nvidia-smi -q | head
              sudo touch /etc/modprobe.d/nvidia.conf
              echo "options nvidia NVreg_EnableGpuFirmware=0" | sudo tee --append /etc/modprobe.d/nvidia.conf
              sudo yum install -y docker
              sudo usermod -a -G docker ec2-user
              sudo systemctl enable docker.service
              sudo systemctl start docker.service
              curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
              sudo yum install -y nvidia-container-toolkit
              sudo nvidia-ctk runtime configure --runtime=docker
              sudo systemctl restart docker
              docker run -d --gpus=all -v ollama:/root/.ollama -p 11434:11434 --name ollama --restart always ollama/ollama
              docker exec -it ollama ollama pull deepseek-r1:14b
              docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v ollama-webui:/app/backend/data --name ollama-webui --restart always ghcr.io/ollama-webui/ollama-webui:main
              EOF
}