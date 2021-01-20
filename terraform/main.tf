#Deploy your ssh key to the OpenStack to use as default to all the vms.
resource "openstack_compute_keypair_v2" "ssh_keypair" {
  name       = "${var.name}_keypair"
  public_key = file(var.key_path)
}
# Create the X instances.
resource "openstack_compute_instance_v2" "Instances" {
  count           = var.instance_count
  name            = format("VM%02d", count.index + 1)
  image_name      = var.image_name
  flavor_name     = var.flavor_name
  key_pair        = openstack_compute_keypair_v2.ssh_keypair.name
  security_groups = [openstack_networking_secgroup_v2.basic_sg.id]

  network {
    name = var.network_name
  }
}
# Creates new IPs from the pool
resource "openstack_networking_floatingip_v2" "Instances_FIP_Pool" {
  count = var.instance_count
  pool  = var.floating_pool
}
# attach the floating IPs to the VMs
resource "openstack_compute_floatingip_associate_v2" "Instances_FIP" {
  count       = var.instance_count
  floating_ip = element(openstack_networking_floatingip_v2.Instances_FIP_Pool.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.Instances.*.id, count.index)
}
# create the hosts file for ansibel with the floating IPs
resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tpl",
    {
      vms_ips = openstack_networking_floatingip_v2.Instances_FIP_Pool.*.address
    }
  )
  filename = "../ansible/hosts"
}
