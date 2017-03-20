module "global-vars" {
    source = "../../global-vars-module"
}

provider "aws" {
  region = "${module.global-vars.default-region}"
}

data "terraform_remote_state" "subnet" {
    backend = "s3"
    config {
        bucket = "${module.global-vars.terraform-state-bucket}"
        key = "${module.global-vars.terraform-state-bucket-base-path}/vpc/subnet/terraform.tfstate"
        region = "${module.global-vars.default-region}"
    }
}

data "terraform_remote_state" "security-group" {
    backend = "s3"
    config {
        bucket = "${module.global-vars.terraform-state-bucket}"
        key = "${module.global-vars.terraform-state-bucket-base-path}/vpc/security-group/terraform.tfstate"
        region = "${module.global-vars.default-region}"
    }
}

data "terraform_remote_state" "hosted-zone" {
    backend = "s3"
    config {
        bucket = "${module.global-vars.terraform-state-bucket}"
        key = "${module.global-vars.terraform-state-bucket-base-path}/route53/hosted-zone/terraform.tfstate"
        region = "${module.global-vars.default-region}"
    }
}