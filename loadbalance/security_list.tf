resource "oci_core_security_list" "SecurityList" {
    compartment_id = oci_identity_compartment.compartmentNet.id 
    display_name = "SecurityList1"
    vcn_id = oci_core_virtual_network.principalVCN.id

    egress_security_rules {
        protocol = "6" // Permite o trafego da vcn para a internet publica
        destination = "0.0.0.0/0" // para qualquer ip
    }

    dynamic "ingress_security_rules" {
        for_each = var.service_ports
        content {
            protocol = "6"
            source = "0.0.0.0/0"
            tcp_options {
                max = ingress_security_rules.value 
                min = ingress_security_rules.value 
            }
        }
    }

    ingress_security_rules {
        protocol = "6"
        source = var.VCN-CIDR
    }

}
