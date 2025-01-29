# Create IAM Role for EC2 Instance
resource "aws_iam_role" "deepseek_r1_role" {
  name = "deepseek-r1-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach Managed Policies to the IAM Role
resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = aws_iam_role.deepseek_r1_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  role       = aws_iam_role.deepseek_r1_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Create IAM Instance Profile
resource "aws_iam_instance_profile" "deepseek_r1_instance_profile" {
  name = "deepseek-r1-instance-profile"
  role = aws_iam_role.deepseek_r1_role.name
}