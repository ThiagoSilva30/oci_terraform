resource "oci_core_internet_gateway" "IG" {
    compartment_id = oci_identity_compartment.compartmentNet.id 
    display_name = "Internet Gateway"
    vcn_id = oci_core_virtual_network.principalVCN.id
}
