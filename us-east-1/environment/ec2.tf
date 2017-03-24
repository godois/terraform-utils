
resource "aws_instance" "ubuntu-example" {
    ami = "${module.global-vars.ubuntu-stable-ami}"
    key_name = "${module.global-vars.instance-key-name}"
    instance_type = "t2.large"
    count="1"
    tags {
        Name = "skapee-jenkins"
    }
    subnet_id = "${data.terraform_remote_state.subnet.skapee-public-1a}"
    root_block_device {
        volume_type = "gp2"
        volume_size = 8
        delete_on_termination = true
    }

    vpc_security_group_ids = ["${data.terraform_remote_state.security-group.skapee-ci-jenkins-sg}"]
}

resource "aws_ebs_volume" "jenkins_volume" {
  availability_zone = "us-east-1a"
  size = 8
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/xvdf"
  volume_id = "${aws_ebs_volume.jenkins_volume.id}"
  instance_id = "${aws_instance.jenkins_instance_1a.id}"
}

resource "aws_eip" "jenkins_elastic_ip" {
  instance = "${aws_instance.jenkins_instance_1a.id}"
  vpc      = true
}