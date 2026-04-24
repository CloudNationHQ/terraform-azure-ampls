# Azure Monitor Private Link Scope

This terraform module simplifies the creation and management of azure monitor private link scope resources, providing customizable options for access modes and scoped service associations, all managed through code.

## Features

Supports configurable ingestion and query access modes (Open or PrivateOnly).

Enables linking multiple scoped services (Log Analytics workspaces, Application Insights components, Data Collection endpoints).

Utilization of terratest for robust validation.

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 4.0)

## Resources

The following resources are used by this module:

- [azurerm_monitor_private_link_scope.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_private_link_scope) (resource)
- [azurerm_monitor_private_link_scoped_service.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_private_link_scoped_service) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_config"></a> [config](#input\_config)

Description: contains all monitor private link scope configuration

Type:

```hcl
object({
    name                  = string
    resource_group_name   = optional(string, null)
    ingestion_access_mode = optional(string, "Open")
    query_access_mode     = optional(string, "Open")
    tags                  = optional(map(string))
    scoped_services = optional(map(object({
      name               = optional(string, null)
      linked_resource_id = string
    })), {})
  })
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: default resource group to be used.

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: tags to be added to the resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_config"></a> [config](#output\_config)

Description: contains all monitor private link scope configuration

### <a name="output_scoped_services"></a> [scoped\_services](#output\_scoped\_services)

Description: contains all monitor private link scoped services configuration
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make docs`

## Contributors

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md). <br><br>

<a href="https://github.com/cloudnationhq/terraform-azure-ampls/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudnationhq/terraform-azure-ampls" />
</a>

## License

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/private-link-security)
- [Rest Api](https://learn.microsoft.com/en-us/rest/api/monitor/private-link-scopes)
- [Rest Api Specs](https://github.com/Azure/azure-rest-api-specs/tree/main/specification/insights/resource-manager/Microsoft.Insights/preview/2021-07-01-preview)
