output "config" {
  description = "contains all monitor private link scope configuration"
  value       = azurerm_monitor_private_link_scope.this
}

output "scoped_services" {
  description = "contains all monitor private link scoped services configuration"
  value       = azurerm_monitor_private_link_scoped_service.this
}
