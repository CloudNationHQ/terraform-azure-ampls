locals {
  zones = {
    private = {
      monitor = {
        name = "privatelink.monitor.azure.com"
        virtual_network_links = {
          link1 = {
            virtual_network_id   = module.network.vnet.id
            registration_enabled = false
          }
        }
      }
      oms = {
        name = "privatelink.oms.opinsights.azure.com"
        virtual_network_links = {
          link1 = {
            virtual_network_id   = module.network.vnet.id
            registration_enabled = false
          }
        }
      }
      ods = {
        name = "privatelink.ods.opinsights.azure.com"
        virtual_network_links = {
          link1 = {
            virtual_network_id   = module.network.vnet.id
            registration_enabled = false
          }
        }
      }
      agentsvc = {
        name = "privatelink.agentsvc.azure-automation.net"
        virtual_network_links = {
          link1 = {
            virtual_network_id   = module.network.vnet.id
            registration_enabled = false
          }
        }
      }
      blob = {
        name = "privatelink.blob.core.windows.net"
        virtual_network_links = {
          link1 = {
            virtual_network_id   = module.network.vnet.id
            registration_enabled = false
          }
        }
      }
    }
  }
}
