provider "oci" {
  version        = ">= 3.0.0"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
  private_key_password  = var.private_key_password
}


resource "oci_core_instance" "vm" {
  count = var.num_instances
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id = var.compartment_id
  shape = var.shape
  display_name  = "vm"

  create_vnic_details {
      #required
      subnet_id = var.subnet_id
      display_name = "primaryvnic" 
      assign_public_ip = true
      hostname_label = "freeinstance0"
  }


   source_details {
      #required
      source_id = var.instance_image_ocid[var.region]
      source_type = "image"
      boot_volume_size_in_gbs  = var.instance_source_details_boot_volume_size_in_gbs
      #kms_key_id = var.kms_keys   
  }

     preserve_boot_volume = false
  
}


