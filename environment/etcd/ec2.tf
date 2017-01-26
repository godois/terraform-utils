data "template_file" "cloud_config_etcd_1a" {
    template = "${file("./etcd-cloud-config-default.tpl")}"
    vars {
        environment = "etcd"
        instance_az = "1a"
    }
}

resource "aws_instance" "etcd_instance_1a" {
    ami = "${module.global-vars.coreos-etcd-stable-ami}"
    key_name = "${module.global-vars.key-name-etcd}"
    instance_type = "t2.micro"
    count="1"
    private_ip = "${module.global-vars.etcd-ips[0]}"
    tags {
        Name = "etcd-1a"
    }
    subnet_id = "${data.terraform_remote_state.subnet.skapee-public-1a}"
    user_data = "${data.template_file.cloud_config_etcd_1a.rendered}"
    root_block_device {
        volume_type = "gp2"
        volume_size = 8
        delete_on_termination = true
    }
    vpc_security_group_ids = ["${data.terraform_remote_state.security-group.skapee-ci-etcd-sg}"]
}

resource "aws_eip" "etcd-1_elastic_ip" {
  instance = "${aws_instance.etcd_instance_1a.id}"
  vpc      = true
}

resource "aws_instance" "etcd_instance_2a" {
    ami = "${module.global-vars.coreos-etcd-stable-ami}"
    key_name = "${module.global-vars.key-name-etcd}"
    instance_type = "t2.micro"
    count="1"
    private_ip = "${module.global-vars.etcd-ips[1]}"
    tags {
        Name = "etcd-2a"
    }
    subnet_id = "${data.terraform_remote_state.subnet.skapee-public-1a}"
    user_data = "${data.template_file.cloud_config_etcd_1a.rendered}"
    root_block_device {
        volume_type = "gp2"
        volume_size = 8
        delete_on_termination = true
    }
    vpc_security_group_ids = ["${data.terraform_remote_state.security-group.skapee-ci-etcd-sg}"]
}

resource "aws_eip" "etcd-2_elastic_ip" {
  instance = "${aws_instance.etcd_instance_2a.id}"
  vpc      = true
}

resource "aws_instance" "etcd_instance_3a" {
    ami = "${module.global-vars.coreos-etcd-stable-ami}"
    key_name = "${module.global-vars.key-name-etcd}"
    instance_type = "t2.micro"
    count="1"
    private_ip = "${module.global-vars.etcd-ips[2]}"
    tags {
        Name = "etcd-3a"
    }
    subnet_id = "${data.terraform_remote_state.subnet.skapee-public-1a}"
    user_data = "${data.template_file.cloud_config_etcd_1a.rendered}"
    root_block_device {
        volume_type = "gp2"
        volume_size = 8
        delete_on_termination = true
    }
    vpc_security_group_ids = ["${data.terraform_remote_state.security-group.skapee-ci-etcd-sg}"]
}

resource "aws_eip" "etcd-3_elastic_ip" {
  instance = "${aws_instance.etcd_instance_3a.id}"
  vpc      = true
}
