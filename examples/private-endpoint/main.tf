module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.26"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "network" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 9.0"

  naming = local.naming

  vnet = {
    name                = module.naming.virtual_network.name
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
    address_space       = ["10.19.0.0/16"]

    subnets = {
      sn1 = {
        network_security_group = {}
        address_prefixes       = ["10.19.1.0/24"]
      }
    }
  }
}

module "analytics" {
  source  = "cloudnationhq/law/azure"
  version = "~> 3.0"

  workspace = {
    name                = module.naming.log_analytics_workspace.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
  }
}

module "ampls" {
  source  = "cloudnationhq/ampls/azure"
  version = "~> 1.0"

  config = {
    name                = module.naming.monitor_private_link_scope.name_unique
    resource_group_name = module.rg.groups.demo.name
    scoped_services = {
      law = {
        linked_resource_id = module.analytics.workspace.id
      }
    }
  }
}

module "private_dns" {
  source  = "cloudnationhq/pdns/azure"
  version = "~> 4.0"

  resource_group_name = module.rg.groups.demo.name

  zones = local.zones
}

module "privatelink" {
  source  = "cloudnationhq/pe/azure"
  version = "~> 2.0"

  resource_group_name = module.rg.groups.demo.name
  location            = module.rg.groups.demo.location

  endpoints = {
    ampls = {
      name      = module.naming.private_endpoint.name
      subnet_id = module.network.subnets.sn1.id

      private_dns_zone_group = {
        private_dns_zone_ids = [
          module.private_dns.private_zones.monitor.id,
          module.private_dns.private_zones.oms.id,
          module.private_dns.private_zones.ods.id,
          module.private_dns.private_zones.agentsvc.id,
          module.private_dns.private_zones.blob.id,
        ]
      }

      private_service_connection = {
        private_connection_resource_id = module.ampls.config.id
        subresource_names              = ["azuremonitor"]
      }
    }
  }
}
