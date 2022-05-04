
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    nxos = {
      source  = "netascode/nxos"
      version = ">= 0.3.7"
    }
  }

  experiments = [module_variable_optional_attrs]
}
