module VDPSupport.Pages.OperationsPage.Domain where

import Concur.Core (Widget)
import Concur.React (HTML)

data ButtonClickAction
  = Refresh
  | PauseConsumer ConsumerServiceInfo
  | ResumeConsumer ConsumerServiceInfo

data ConfirmDialogAction
  = Confirm
  | Cancel

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

type MarketInfo
  = { marketName :: String
    , consumers :: ConsumerServiceInfoArray
    }

type MarketInfoArray
  = Array MarketInfo

type ConsumerServiceInfo
  = { ipAddress :: String
    , statusEndpoint :: String
    , pauseEndpoint :: String
    , resumeEndpoint :: String
    }

type ConsumerServiceInfoArray
  = Array ConsumerServiceInfo

data ConsumerServiceStatus
  = Running
  | Paused
  | FailedToFetch
