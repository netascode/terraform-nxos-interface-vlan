terraform {
  required_version = ">= 1.0.0"

  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    nxos = {
      source  = "CiscoDevNet/nxos"
      version = ">= 0.5.0"
    }
  }
}

module "main" {
  source = "../.."

  id = "10"
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
}
