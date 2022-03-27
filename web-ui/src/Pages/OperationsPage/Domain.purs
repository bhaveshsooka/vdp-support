module VDPSupport.Pages.OperationsPage.Domain where

import Concur.Core (Widget)
import Concur.React (HTML)

data ButtonClickAction
  = Refresh

type LegendItem
  = { widget :: forall a. Widget HTML a
    , label :: String
    }

type LegendItemArray
  = Array LegendItem

type HealthCheckInfo
  = { serviceName :: String
    , healthCheckEndpoint :: String
    }

type HealthCheckInfoArray
  = Array HealthCheckInfo


