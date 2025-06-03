variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "owner_name" {
  description = "Name of the resource owner (for tagging)"
  type        = string
  default     = "JLuuc"
}

variable "project_name" {
  description = "Project tag"
  type        = string
  default     = "DevOpsFinalExam"
}

variable "key_pair_path" {
  description = "Local path to public key to upload to AWS"
  type        = string
  default     = "./id_rsa.pub"
}

