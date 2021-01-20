# Number of vms to create
variable "instance_count" {
  default = "3"
}
# Admin's name
variable "name" {
  type    = string
  default = "Ilana"
}
# you public ssh-key path
variable "key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}
# make sure you have this image name in you openstack
variable "image_name" {
  type    = string
  default = "centos-7-x86_64"
}
# make sure you have this flavor name in you openstack
variable "flavor_name" {
  type    = string
  default = "m1.s2.large"
}
# make sure you have this pool name in you openstack
variable "floating_pool" {
  type    = string
  default = "external"
}
# make sure you have this network name in you openstack
variable "network_name" {
  type    = string
  default = "default_network"
}


