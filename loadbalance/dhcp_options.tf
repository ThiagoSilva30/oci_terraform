resource "oci_core_dhcp_options" "principalDHCP" {
    compartment_id = oci_identity_compartment.compartmentNet.id
    vcn_id = oci_core_virtual_network.principalVCN.id
    display_name = "principalDHCP"

    options {
        type = "DomainNameServer"
        server_type = "VcnLocalPlusInternet"
    }    
  
}
