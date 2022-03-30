module VDPSupport.Pages.OperationsPage.Domain where

import Prelude
import Concur.Core (Widget)
import Concur.React (HTML)
import Data.Array (concat)
import Record (merge)

-----------------------------------------------------------
data ButtonClickAction
  = Refresh
  | PauseConsumer FlattenedConsumerServiceInfo
  | ResumeConsumer FlattenedConsumerServiceInfo

-----------------------------------------------------------
data ConfirmDialogAction
  = Confirm
  | Cancel

-----------------------------------------------------------
type LegendItem
  = { widget :: forall a. Widget HTML a
    , label :: String
    }

type LegendItemArray
  = Array LegendItem

-----------------------------------------------------------
type HealthCheckInfo
  = { serviceName :: String
    , healthCheckEndpoint :: String
    }

type HealthCheckInfoArray
  = Array HealthCheckInfo

-----------------------------------------------------------
flattenMarketInfoArray :: MarketInfoArray -> FlattenedConsumerServiceInfoArray
flattenMarketInfoArray marketInfoArray =
  concat
    $ marketInfoArray
    <#> ( \marketInfo ->
          concat $ marketInfo.environments
            <#> ( \environmentInfo ->
                  environmentInfo.consumers
                    <#> (\consumerServiceInfo -> merge consumerServiceInfo { marketName: marketInfo.marketName, environmentName: environmentInfo.environmentName })
              )
      )

type MarketInfo
  = { marketName :: String
    , environments :: EnvironmentInfoArray
    }

type EnvironmentInfo
  = { environmentName :: String
    , consumers :: ConsumerServiceInfoArray
    }

type EnvironmentInfoArray
  = Array EnvironmentInfo

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

type FlattenedConsumerServiceInfo
  = { marketName :: String
    , environmentName :: String
    , ipAddress :: String
    , statusEndpoint :: String
    , pauseEndpoint :: String
    , resumeEndpoint :: String
    }

type FlattenedConsumerServiceInfoArray
  = Array FlattenedConsumerServiceInfo

-----------------------------------------------------------
data ConsumerServiceStatus
  = Running
  | Paused
  | FailedToFetch
