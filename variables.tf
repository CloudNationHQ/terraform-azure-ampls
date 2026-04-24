variable "config" {
  description = "contains all monitor private link scope configuration"
  type = object({
    name                  = optional(string)
    resource_group_name   = optional(string)
    ingestion_access_mode = optional(string, "Open")
    query_access_mode     = optional(string, "Open")
    tags                  = optional(map(string))
    scoped_services = optional(map(object({
      name               = optional(string)
      linked_resource_id = string
    })), {})
  })

  validation {
    condition     = var.config.resource_group_name != null || var.resource_group_name != null
    error_message = "resource group name must be provided either in the config object or as a separate variable."
  }

  validation {
    condition     = contains(["Open", "PrivateOnly"], var.config.ingestion_access_mode)
    error_message = "ingestion_access_mode must be either 'Open' or 'PrivateOnly'."
  }

  validation {
    condition     = contains(["Open", "PrivateOnly"], var.config.query_access_mode)
    error_message = "query_access_mode must be either 'Open' or 'PrivateOnly'."
  }
}

variable "resource_group_name" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
