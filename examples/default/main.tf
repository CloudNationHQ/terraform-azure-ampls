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
