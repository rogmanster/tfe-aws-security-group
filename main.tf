//--------------------------------------------------------------------
// Variables



//--------------------------------------------------------------------
// Workspace Data
data "terraform_remote_state" "rogercorp_aws_vpc_prod" {
  backend = "atlas"
  config {
    address = "app.terraform.io"
    name    = "rogercorp/aws-vpc-prod"
  }
}

//--------------------------------------------------------------------
// Modules
module "ec2_instance" {
  source  = "app.terraform.io/rogercorp/ec2-instance/aws"
  version = "1.21.0"

  ami = "ami-0932686c"
  instance_type = "t2.small"
  name = "aws-module-instance-1"
  subnet_ids = ["${data.terraform_remote_state.rogercorp_aws_vpc_prod.public_subnets}"]
  vpc_security_group_ids = ["${module.security_group.this_security_group_id}"]
}

module "security_group" {
  source  = "app.terraform.io/rogercorp/security-group/aws"
  version = "2.17.0"

  name = "security-group-1"
  vpc_id = "${data.terraform_remote_state.rogercorp_aws_vpc_prod.vpc_id}"
}
