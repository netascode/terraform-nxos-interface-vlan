variable "device" {
  description = "A device name from the provider configuration."
  type        = string
  default     = null
}

variable "id" {
  description = "Interface ID. Allowed format: `1`."
  type        = number

  validation {
    condition     = try(var.id >= 1 && var.id <= 4094, false)
    error_message = "Minimum value: 1. Maximum value: 4094."
  }
}

variable "admin_state" {
  description = "Administrative port state. Set `true` for `up` or `false` for `down`."
  type        = bool
  default     = true
}

variable "delay" {
  description = "The administrative port delay time. Minimum value: 1. Maximum value: 16777215."
  type        = number
  default     = 1

  validation {
    condition     = try(var.delay >= 1 && var.delay <= 16777215, false)
    error_message = "Minimum value: 1. Maximum value: 16777215."
  }
}

variable "description" {
  description = "Interface description."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^.{0,254}$", var.description))
    error_message = " Maximum characters: 254."
  }
}

variable "bandwidth" {
  description = "Interface bandwidth. Minimum value: 1. Maximum value: 400000000."
  type        = number
  default     = 1000000

  validation {
    condition     = try(var.bandwidth >= 1 && var.bandwidth <= 400000000, false)
    error_message = "Minimum value: 1. Maximum value: 400000000."
  }
}

variable "ip_forward" {
  description = "Enable/disable command `ip forward`."
  type        = bool
  default     = false
}

variable "ip_drop_glean" {
  description = "Enable/disable command `ip drop-glean`."
  type        = bool
  default     = false
}

variable "medium" {
  description = "Administrative port medium type."
  type        = string
  default     = "bcast"

  validation {
    condition     = contains(["bcast", "p2p"], var.medium)
    error_message = "Valid values are `bcast` or `p2p`."
  }
}

variable "mtu" {
  description = "Administrative port MTU. Minimum value: 576. Maximum value: 9216."
  type        = number
  default     = 1500

  validation {
    condition     = try(var.mtu >= 576 && var.mtu <= 9216, false)
    error_message = "Minimum value: 576. Maximum value: 9216."
  }
}

variable "vrf" {
  description = "VRF Name."
  type        = string
  default     = "default"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,32}$", var.vrf))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 32."
  }
}

variable "ipv4_address" {
  description = "Interface IPv4 address. Allowed format: `192.168.0.1/24`."
  type        = string
  default     = null

  validation {
    condition     = var.ipv4_address == null || can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+\\/\\d+$", var.ipv4_address))
    error_message = "Allowed characters: `0`-`9`, `.`, `/`."
  }
}

variable "ipv4_secondary_addresses" {
  description = "List of Interface IPv4 secondary addresses. Allowed format: `192.168.0.1/24`."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for v in var.ipv4_secondary_addresses : can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+\\/\\d+$", v))
    ])
    error_message = "Allowed characters: `0`-`9`, `.`, `/`."
  }
}
