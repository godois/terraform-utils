resource "aws_route53_record" "etcd-1_record" {
  zone_id = "${data.terraform_remote_state.hosted-zone.skapee-hosted-zone-id}"
  name = "etcd-1.skapee.com"
  type = "A"
  ttl = "300"
  records = ["${aws_eip.etcd-1_elastic_ip.public_ip}"]
}

resource "aws_route53_record" "etcd-2_record" {
  zone_id = "${data.terraform_remote_state.hosted-zone.skapee-hosted-zone-id}"
  name = "etcd-2.skapee.com"
  type = "A"
  ttl = "300"
  records = ["${aws_eip.etcd-2_elastic_ip.public_ip}"]
}

resource "aws_route53_record" "etcd-3_record" {
  zone_id = "${data.terraform_remote_state.hosted-zone.skapee-hosted-zone-id}"
  name = "etcd-3.skapee.com"
  type = "A"
  ttl = "300"
  records = ["${aws_eip.etcd-3_elastic_ip.public_ip}"]
}