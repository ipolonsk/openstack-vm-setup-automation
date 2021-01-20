# create the security group
resource "openstack_networking_secgroup_v2" "basic_sg" {
  name        = "basic_sg"
  description = "Allows SSH & XRDP"
}
# Create two rules for ssh and XRDP
resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.basic_sg.id
}

resource "openstack_networking_secgroup_rule_v2" "xrdp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3389
  port_range_max    = 3389
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.basic_sg.id
}
