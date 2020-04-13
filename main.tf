// Workspace Data
data "terraform_remote_state" "rogercorp_aws_vpc_prod" {
  backend = "remote"

  config = {
   organization = "rogercorp"
   workspaces = {
     name = "aws-vpc-prod"
   }
  }
}

module "security-group" {
  source  = "app.terraform.io/rogercorp/security-group-PMR/tfe"
  version = "1.0.0"

  name   = "rchao"
  vpc_id = data.terraform_remote_state.rogercorp_aws_vpc_prod.outputs.vpc_id

  ingress = {
    description = "http"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress = {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
