data "openstack_networking_network_v2" "external" {
  network_id = "${var.external_network_id}"
}

resource "openstack_networking_network_v2" "internal" {
  name           = "${var.project}-pas-internal-network"
  region         = "${var.region}"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "internal" {
  name       = "${var.project}-pas-internal-subnet"
  network_id = "${openstack_networking_network_v2.internal.id}"
  region     = "${var.region}"
  cidr       = "${var.internal_cidr}"
}

resource "openstack_networking_router_v2" "internal" {
  name                = "${var.project}-pas-internal-router"
  region              = "${var.region}"
  external_network_id = "${data.openstack_networking_network_v2.external.id}"
  admin_state_up      = "true"
  tenant_id           = "${var.project}"
}

resource "openstack_networking_router_interface_v2" "internal" {
  region    = "${var.region}"
  router_id = "${openstack_networking_router_v2.internal.id}"
  subnet_id = "${openstack_networking_subnet_v2.internal.id}"
}

resource "openstack_networking_floatingip_v2" "ops_manager" {
  region = "${var.region}"
  pool   = "${data.openstack_networking_network_v2.external.name}"
}

resource "openstack_networking_floatingip_v2" "ha_proxy" {
  region = "${var.region}"
  pool   = "${data.openstack_networking_network_v2.external.name}"
}
