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
  source = "app.terraform.io/rogercorp/security-group/aws//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "${data.terraform_remote_state.rogercorp_aws_vpc_prod.vpc_id}"

  ingress_cidr_blocks = ["${data.terraform_remote_state.rogercorp_aws_vpc_prod.vpc_cidr_block}"]
}
  
output "this_security_group_id" {
  description = "The ID of the security group"
  value       = module.web_server_sg.this_security_group_id
}

output "this_security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.web_server_sg.this_security_group_vpc_id
}

output "this_security_group_owner_id" {
  description = "The owner ID"
  value       = module.web_server_sg.this_security_group_owner_id
}

output "this_security_group_name" {
  description = "The name of the security group"
  value       = module.web_server_sg.this_security_group_name
}

output "this_security_group_description" {
  description = "The description of the security group"
  value       = module.web_server_sg.this_security_group_description
}


