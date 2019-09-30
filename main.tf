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
module "security_group" {
  source  = "app.terraform.io/rogercorp/security-group/aws"
  version = "2.17.0"#

  name = "security-group-1"
  vpc_id = "${data.terraform_remote_state.rogercorp_aws_vpc_prod.vpc_id}"
}

output "vpc-id" {
  value = "${data.terraform_remote_state.rogercorp_aws_vpc_prod.vpc_id}"
}

