#############################
# main.tf
#############################

#--------------------------------------------------
# PROVIDER & TERRAFORM CONFIGURATION
#--------------------------------------------------

provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

#--------------------------------------------------
# OUTPUTS
#--------------------------------------------------

# Public IP of the Jenkins Controller instance
output "jenkins_controller_public_ip" {
  description = "The public IP address of the Jenkins Controller EC2 instance."
  value       = aws_instance.jenkins_controller.public_ip
}

# Public IP of the Testing environment instance
output "testing_env_public_ip" {
  description = "The public IP address of the Testing environment EC2 instance."
  value       = aws_instance.testing_env.public_ip
}

# Public IP of the Staging environment instance
output "staging_env_public_ip" {
  description = "The public IP address of the Staging environment EC2 instance."
  value       = aws_instance.staging_env.public_ip
}

# DNS name of the Production Application Load Balancer
output "prod_alb_dns_name" {
  description = "The DNS name of the Production Application Load Balancer."
  value       = aws_lb.prod_lb.dns_name
}

# List of all EC2 instance IDs (Jenkins + Agents + Testing + Staging + Production)
output "all_instance_ids" {
  description = "All EC2 instance IDs created for Jenkins Controller, Jenkins Agents, Testing, Staging, and Production."
  value = [
    aws_instance.jenkins_controller.id,
    aws_instance.jenkins_permanent_agent.id,
    aws_instance.jenkins_dynamic_agent.id,
    aws_instance.testing_env.id,
    aws_instance.staging_env.id,
    aws_instance.prod_env_1.id,
    aws_instance.prod_env_2.id,
  ]
}

