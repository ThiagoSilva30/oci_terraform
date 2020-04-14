resource "oci_load_balancer" "LoadBalancer" {
  shape          = "100Mbps"
  compartment_id = oci_identity_compartment.compartmentNet.id
  subnet_ids     = [
    oci_core_subnet.Subnet1.id
  ]
  display_name   = "LoadBalancerWebServers"
}

resource "oci_load_balancer_backendset" "LoadBalancerBackendset" {
  name             = "LBBackendset"
  load_balancer_id = oci_load_balancer.LoadBalancer.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port     = "80"
    protocol = "HTTP"
    response_body_regex = ".*"
    url_path = "/"
  }
}


resource "oci_load_balancer_listener" "LoadBalancerListener" {
  load_balancer_id         = oci_load_balancer.LoadBalancer.id
  name                     = "LoadBalancerListener"
  default_backend_set_name = oci_load_balancer_backendset.LoadBalancerBackendset.name
  port                     = 80
  protocol                 = "HTTP"
}


resource "oci_load_balancer_backend" "LoadBalancerBackend" {
  load_balancer_id = oci_load_balancer.LoadBalancer.id
  backendset_name  = oci_load_balancer_backendset.LoadBalancerBackendset.name
  ip_address       = oci_core_instance.webserver1.private_ip
  port             = 80 
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "LoadBalancerBackend2" {
  load_balancer_id = oci_load_balancer.LoadBalancer.id
  backendset_name  = oci_load_balancer_backendset.LoadBalancerBackendset.name
  ip_address       = oci_core_instance.webserver2.private_ip
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}


output "LoadBalancer_Public_IP" {
  value = [oci_load_balancer.LoadBalancer.ip_addresses]
}