terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    nxos = {
      source  = "netascode/nxos"
      version = ">=0.3.7"
    }
  }
}

resource "nxos_vrf" "vrf" {
  name = "VRF1"
}

module "main" {
  source = "../.."

  id           = "10"
  admin_state  = true
  vrf          = "VRF1"
  ipv4_address = "3.1.1.1/24"
  description  = "Terraform was here"
  mtu          = 9216

  depends_on = [nxos_vrf.vrf]
}

data "nxos_svi_interface" "sviIf" {
  interface_id = "vlan10"

  depends_on = [module.main]
}

resource "test_assertions" "sviIf" {
  component = "sviIf"

  equal "interface_id" {
    description = "interface_id"
    got         = data.nxos_svi_interface.sviIf.interface_id
    want        = "vlan10"
  }

  equal "admin_state" {
    description = "admin_state"
    got         = data.nxos_svi_interface.sviIf.admin_state
    want        = "up"
  }

  equal "description" {
    description = "description"
    got         = data.nxos_svi_interface.sviIf.description
    want        = "Terraform was here"
  }

  equal "mtu" {
    description = "mtu"
    got         = data.nxos_svi_interface.sviIf.mtu
    want        = 9216
  }
}

data "nxos_svi_interface_vrf" "nwRtVrfMbr" {
  interface_id = "vlan10"

  depends_on = [module.main]
}

resource "test_assertions" "nwRtVrfMbr" {
  component = "nwRtVrfMbr"

  equal "vrf_dn" {
    description = "vrf_dn"
    got         = data.nxos_svi_interface_vrf.nwRtVrfMbr.vrf_dn
    want        = "sys/inst-VRF1"
  }
}

data "nxos_ipv4_interface_address" "ipv4Addr" {
  interface_id = "vlan10"
  vrf          = "VRF1"
  address      = "3.1.1.1/24"

  depends_on = [module.main]
}

resource "test_assertions" "ipv4Addr" {
  component = "ipv4Addr"

  equal "address" {
    description = "address"
    got         = data.nxos_ipv4_interface_address.ipv4Addr.address
    want        = "3.1.1.1/24"
  }
}
