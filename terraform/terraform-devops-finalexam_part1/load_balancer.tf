###########################
# load_balancer.tf
###########################

# Application Load Balancer
resource "aws_lb" "prod_lb" {
  name               = "Prod-ALB"
  internal           = false
  load_balancer_type = "application"

  # We must specify TWO subnets in different AZs here:
  subnets = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id,
  ]

  security_groups = [
    aws_security_group.public_sg.id,
  ]

  tags = {
    Name    = "Prod-ALB"
    Project = "DevOpsFinalExam"
  }
}

# Target Group for Production
resource "aws_lb_target_group" "prod_tg" {
  name     = "Prod-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name    = "Prod-TG"
    Project = "DevOpsFinalExam"
  }
}

# Listener (port 80 → forward to prod_tg)
resource "aws_lb_listener" "prod_listener" {
  load_balancer_arn = aws_lb.prod_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_tg.arn
  }
}

# Attach ProductionEnv1 to the target group
resource "aws_lb_target_group_attachment" "prod_env1_attachment" {
  target_group_arn = aws_lb_target_group.prod_tg.arn
  target_id        = aws_instance.prod_env_1.id
  port             = 80
}

# Attach ProductionEnv2 to the target group
resource "aws_lb_target_group_attachment" "prod_env2_attachment" {
  target_group_arn = aws_lb_target_group.prod_tg.arn
  target_id        = aws_instance.prod_env_2.id
  port             = 80
}

