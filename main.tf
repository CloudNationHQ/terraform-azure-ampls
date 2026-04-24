# private link scope
resource "azurerm_monitor_private_link_scope" "this" {
  name = var.config.name

  resource_group_name = coalesce(
    lookup(var.config, "resource_group_name", null),
    var.resource_group_name
  )

  ingestion_access_mode = var.config.ingestion_access_mode
  query_access_mode     = var.config.query_access_mode

  tags = coalesce(
    var.config.tags, var.tags
  )
}

# scoped services
resource "azurerm_monitor_private_link_scoped_service" "this" {
  for_each = { for k, v in var.config.scoped_services : k => v }

  name = coalesce(
    each.value.name, each.key
  )

  resource_group_name = coalesce(
    lookup(var.config, "resource_group_name", null),
    var.resource_group_name
  )

  scope_name         = azurerm_monitor_private_link_scope.this.name
  linked_resource_id = each.value.linked_resource_id
}
