resource "oci_core_instance" "webserver1" {
    availability_domain = var.ADs[2]
    compartment_id = oci_identity_compartment.compartmentVM.id
    display_name = "webserver1"
    shape = var.Shapes[1]
    fault_domain = "FAULT-DOMAIN-1"
    subnet_id = oci_core_subnet.Subnet1.id

    source_details {
        source_type = "image"
        source_id = var.Images[0]
    }

    metadata = {
        ssh_authorized_keys = file(var.public_instance_key)
    }   

    create_vnic_details {
        subnet_id = oci_core_subnet.Subnet1.id 
        assign_public_ip = true
    }
}

data "oci_core_vnic_attachments" "webserver1_VNIC1_attach" {
    availability_domain = var.ADs[2]
    compartment_id = oci_identity_compartment.compartmentVM.id
    instance_id = oci_core_instance.webserver1.id
}

data "oci_core_vnic" "webserver1_VNIC1" {
    vnic_id = data.oci_core_vnic_attachments.webserver1_VNIC1_attach.vnic_attachments.0.vnic_id
}

output "webserver1PublicIP" {
  value = [data.oci_core_vnic.webserver1_VNIC1.public_ip_address]
}



