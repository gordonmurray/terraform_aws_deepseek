# Output the EC2 instance public IP with port 3000 appended
output "deepseek_r1_public_ip" {
  value = "http://${aws_instance.deepseek_r1.public_ip}:3000"
  description = "EC2 Instance Public IP with Port 3000"
}