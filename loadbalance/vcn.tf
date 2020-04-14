resource "oci_core_virtual_network" "principalVCN" {
    cidr_block = var.VCN-CIDR 
    dns_label = "principalVCN"
    compartment_id = oci_identity_compartment.compartmentNet.id
    display_name = "principalVCN"
}
