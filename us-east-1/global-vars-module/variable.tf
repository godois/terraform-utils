variable "default-region" { default = "us-east-1" }
variable "terraform-state-bucket" { default = "example-s3-bucket-name" }
variable "terraform-state-bucket-base-path" { default = "key=base" }
variable "ubuntu-stable-ami" { default = "ami-f4cc1de2" }
variable "instance-key-name" { default = "ubuntu-example" }