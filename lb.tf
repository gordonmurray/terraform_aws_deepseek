

# Create Application Load Balancer
resource "aws_lb" "deepseek_alb" {
  name                       = "deepseek-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.deepseek_sg.id]
  subnets                    = [aws_subnet.public[0].id, aws_subnet.public[1].id]
  enable_deletion_protection = false
}

# Create Target Group for ALB
resource "aws_lb_target_group" "deepseek_tg" {
  name     = "deepseek-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

# Attach EC2 Instance to Target Group
resource "aws_lb_target_group_attachment" "deepseek_tg_attachment" {
  target_group_arn = aws_lb_target_group.deepseek_tg.arn
  target_id        = aws_instance.deepseek_r1.id
  port             = 3000
}

# Create ALB Listener
resource "aws_lb_listener" "deepseek_listener" {
  load_balancer_arn = aws_lb.deepseek_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.deepseek_tg.arn
  }
}
