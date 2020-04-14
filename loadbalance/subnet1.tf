resource "oci_core_subnet" "Subnet1" {
    cidr_block = "10.0.1.0/24"
    display_name = "Subnet1"
    dns_label = "coreSubnet1"

    compartment_id = oci_identity_compartment.compartmentNet.id
    vcn_id = oci_core_virtual_network.principalVCN.id
    route_table_id = oci_core_route_table.RouteTable1.id
    dhcp_options_id = oci_core_dhcp_options.principalDHCP.id
    security_list_ids = [oci_core_security_list.SecurityList.id]
}
