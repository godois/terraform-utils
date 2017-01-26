#cloud-config

hostname: etcd-node
coreos:
  etcd2:
    discovery: https://discovery.etcd.io/2045f0b48ae8766daf85339d929b0115
    advertise-client-urls: http://$private_ipv4:2379
    initial-advertise-peer-urls: http://$private_ipv4:2380
    listen-client-urls: http://0.0.0.0:2379
    listen-peer-urls: http://$private_ipv4:2380
  units:
    - name: etcd2.service
      command: start