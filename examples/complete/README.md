<!-- BEGIN_TF_DOCS -->
# NX-OS Vlan Interface Example

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources. Resources can be destroyed with `terraform destroy`.

```hcl
module "nxos_interface_vlan" {
  source  = "netascode/interface-vlan/nxos"
  version = ">= 0.1.0"

  id           = 10
  admin_state  = true
  vrf          = "VRF1"
  ipv4_address = "3.1.1.1/24"
  description  = "Terraform was here"
  mtu          = 9216
}
```
<!-- END_TF_DOCS -->