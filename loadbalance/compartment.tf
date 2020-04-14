resource "oci_identity_compartment" "compartmentVM"{

    name = "compartmentVM"
    description = "Compartment to vm instances"
}

resource "oci_identity_compartment" "compartmentNet"{

    name = "compartmentNet"
    description = "Compartment to network resources"
}

resource "oci_identity_compartment" "compartmentDB"{

    name = "compartmentDB"
    description = "Compartment to database resources"
}

