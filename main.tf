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

// Modules
module "web_server_sg" {
  source  = "app.terraform.io/rogercorp/security-group-PMR/aws"
  version = "3.4.0"

  name        = "${name}-web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = data.terraform_remote_state.rogercorp_aws_vpc_prod.outputs.vpc_id

  ingress_cidr_blocks = [ data.terraform_remote_state.rogercorp_aws_vpc_prod.outputs.cidr_block ]
}
