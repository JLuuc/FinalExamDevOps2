#-------------------------------------------------------------------
# Compute instances for Jenkins and environments
#-------------------------------------------------------------------

locals {
  ami_id      = "ami-0c02fb55956c7d316"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"
}

# Jenkins Controller
resource "aws_instance" "jenkins_controller" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id              = aws_subnet.public_subnet_1.id
  tags = {
    Name    = "JenkinsController"
    Owner   = var.owner_name
    Project = var.project_name
  }
}

# Jenkins Permanent Agent
resource "aws_instance" "jenkins_permanent_agent" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id              = aws_subnet.public_subnet_1.id
  tags = {
    Name    = "JenkinsPermanentAgent"
    Owner   = var.owner_name
    Project = var.project_name
  }
}

# Jenkins Dynamic Agent
resource "aws_instance" "jenkins_dynamic_agent" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id              = aws_subnet.public_subnet_2.id
  tags = {
    Name    = "JenkinsDynamicAgent"
    Owner   = var.owner_name
    Project = var.project_name
  }
}

# Testing Environment
resource "aws_instance" "testing_env" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id              = aws_subnet.public_subnet_2.id
  tags = {
    Name    = "TestingEnv"
    Owner   = var.owner_name
    Project = var.project_name
  }
}

# Staging Environment
resource "aws_instance" "staging_env" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id              = aws_subnet.public_subnet_1.id
  tags = {
    Name    = "StagingEnv"
    Owner   = var.owner_name
    Project = var.project_name
  }
}

# Production Environment Instance 1
resource "aws_instance" "prod_env_1" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id              = aws_subnet.public_subnet_1.id
  tags = {
    Name    = "ProductionEnv1"
    Owner   = var.owner_name
    Project = var.project_name
  }
}

# Production Environment Instance 2
resource "aws_instance" "prod_env_2" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id              = aws_subnet.public_subnet_2.id
  tags = {
    Name    = "ProductionEnv2"
    Owner   = var.owner_name
    Project = var.project_name
  }
}

