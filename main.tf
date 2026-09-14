# private link scope
resource "azurerm_monitor_private_link_scope" "this" {
  name = var.monitor_private_link_scope.name

  resource_group_name = coalesce(
    var.monitor_private_link_scope.resource_group_name, var.resource_group_name
  )

  ingestion_access_mode = var.monitor_private_link_scope.ingestion_access_mode
  query_access_mode     = var.monitor_private_link_scope.query_access_mode

  tags = coalesce(
    var.monitor_private_link_scope.tags, var.tags
  )
}

# scoped services
resource "azurerm_monitor_private_link_scoped_service" "this" {
  for_each = var.monitor_private_link_scope.scoped_services

  name = coalesce(
    each.value.name, each.key
  )

  resource_group_name = coalesce(
    var.monitor_private_link_scope.resource_group_name,
    var.resource_group_name
  )

  scope_name         = azurerm_monitor_private_link_scope.this.name
  linked_resource_id = each.value.linked_resource_id
}
