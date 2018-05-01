resource "openstack_images_image_v2" "ops_manager" {
  name             = "${var.project}-ops-manager"
  image_source_url = "${var.ops_manager_image_url}"
  container_format = "bare"
  disk_format      = "raw"
  min_disk_gb      = 80
  min_ram_mb       = 8192
  protected        = true
}

resource "openstack_compute_instance_v2" "ops_manager" {
  name            = "${var.project}-ops-manager"
  image_id        = "${openstack_images_image_v2.ops_manager.id}"
  flavor_name     = "${var.flavor_name}"
  key_pair        = "${var.keypair}"
  security_groups = ["${openstack_compute_secgroup_v2.ops-manager.id}"]

  network {
    name = "${openstack_networking_network_v2.internal.name}"
  }
}

resource "openstack_compute_floatingip_associate_v2" "ops_manager_ip" {
  floating_ip = "${openstack_networking_floatingip_v2.ops_manager.address}"
  instance_id = "${openstack_compute_instance_v2.ops_manager.id}"
}
