# Upload your existing public key into AWS (key name "devops_finalexam_key")
resource "aws_key_pair" "devops_key" {
  key_name   = "devops_finalexam_key"
  public_key = file(var.key_pair_path)
}

