#!/bin/bash
# Update and install dependencies
sudo yum update -y
sudo yum install -y gcc make kernel-devel-$(uname -r)

# Install NVIDIA drivers
cd ~
aws s3 cp --recursive s3://ec2-linux-nvidia-drivers/latest/ .
chmod +x NVIDIA-Linux-x86_64*.run
mkdir /home/ssm-user/tmp
chmod -R 777 tmp
cd /home/ssm-user
export TMPDIR=/home/ssm-user/tmp
CC=/usr/bin/gcc ~/NVIDIA-Linux-x86_64*.run --tmpdir=$TMPDIR -s
sudo touch /etc/modprobe.d/nvidia.conf
echo "options nvidia NVreg_EnableGpuFirmware=0" | sudo tee --append /etc/modprobe.d/nvidia.conf

# Verify NVIDIA drivers
nvidia-smi -q | head

# Install Docker
sudo yum install -y docker
sudo usermod -a -G docker ec2-user
sudo systemctl enable docker.service
sudo systemctl start docker.service

# Install NVIDIA Container Toolkit
curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
sudo yum install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

# Run Ollama container with NVIDIA runtime
sudo docker run -d --runtime=nvidia -v ollama:/root/.ollama -p 11434:11434 --name ollama --restart always ollama/ollama

# Pull the DeepSeek model
docker exec -it ollama ollama pull deepseek-r1:14b

# Run Ollama Web UI
docker run -d -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v ollama-webui:/app/backend/data \
  --name ollama-webui \
  --restart always \
  ghcr.io/ollama-webui/ollama-webui:main