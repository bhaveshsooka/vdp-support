module VDPSupport.Pages.OperationsPage
  ( operationsPage
  ) where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Control.Alt ((<|>))
import VDPSupport.Pages.OperationsPage.OperationsPageTypes (MyTab(..), MyTabAction(..))
import VDPSupport.Styles (operationsButtonGroupsStyle, operationsButtonStyle, operationsContentStyle, topbarItemStyle, topbarStyle)

operationsPage :: forall a. MyTab -> MyTabAction -> Widget HTML a
operationsPage activeTab action = do
  selectedTab <-
    D.div [ topbarStyle ]
      [ D.a
          [ topbarItemStyle (ConsumerRestarts == activeTab) (action == Hover)
          , P.onClick $> Click
          -- , P.onMouseLeave $> Unhover
          -- , P.onMouseOver $> Hover
          ]
          [ D.text "Consumer Restarts" ]
          $> ConsumerRestarts
      , D.a
          [ topbarItemStyle (HealthChecks == activeTab) (action == Hover)
          , P.onClick $> Click
          -- , P.onMouseLeave $> Unhover
          -- , P.onMouseOver $> Hover
          ]
          [ D.text "Health Checks" ]
          $> HealthChecks
      ]
      <|> case activeTab of
          ConsumerRestarts -> consumerRestartsContent
          HealthChecks -> healthCheckContent
  operationsPage selectedTab action

type ConsumerServiceInfo
  = { marketName :: String
    , pauseEndpoint :: String
    , restartEndpoint :: String
    }

consumerServices :: Array ConsumerServiceInfo
consumerServices =
  [ { marketName: "market1", pauseEndpoint: "http:service1/pause", restartEndpoint: "http:service1/restart" }
  , { marketName: "market2", pauseEndpoint: "http:service2/pause", restartEndpoint: "http:service2/restart" }
  , { marketName: "market3", pauseEndpoint: "http:service3/pause", restartEndpoint: "http:service3/restart" }
  , { marketName: "market4", pauseEndpoint: "http:service4/pause", restartEndpoint: "http:service4/restart" }
  , { marketName: "market5", pauseEndpoint: "http:service5/pause", restartEndpoint: "http:service5/restart" }
  , { marketName: "market6", pauseEndpoint: "http:service6/pause", restartEndpoint: "http:service6/restart" }
  , { marketName: "market7", pauseEndpoint: "http:service7/pause", restartEndpoint: "http:service7/restart" }
  , { marketName: "market8", pauseEndpoint: "http:service8/pause", restartEndpoint: "http:service8/restart" }
  , { marketName: "market9", pauseEndpoint: "http:service9/pause", restartEndpoint: "http:service9/restart" }
  ]

consumerRestartsContent :: forall a. Widget HTML a
consumerRestartsContent =
  D.div
    [ operationsContentStyle ]
    (map buttonGroups consumerServices)
  where
  buttonGroups :: forall b. ConsumerServiceInfo -> Widget HTML b
  buttonGroups consumerService =
    D.div [ operationsButtonGroupsStyle ]
      [ D.h3' [ D.text consumerService.marketName ]
      , D.button [ operationsButtonStyle "#aa0441" ] [ D.text "Pause" ]
      , D.button [ operationsButtonStyle "#04AA6D" ] [ D.text "Restart" ]
      ]

type HealthCheckInfo
  = { serviceName :: String
    , healthCheckEndpoint :: String
    }

healthCheckServices :: Array HealthCheckInfo
healthCheckServices =
  [ { serviceName: "service1", healthCheckEndpoint: "http:service1/health" }
  , { serviceName: "service2", healthCheckEndpoint: "http:service2/health" }
  , { serviceName: "service3", healthCheckEndpoint: "http:service3/health" }
  , { serviceName: "service4", healthCheckEndpoint: "http:service4/health" }
  , { serviceName: "service5", healthCheckEndpoint: "http:service5/health" }
  , { serviceName: "service6", healthCheckEndpoint: "http:service6/health" }
  , { serviceName: "service7", healthCheckEndpoint: "http:service7/health" }
  , { serviceName: "service8", healthCheckEndpoint: "http:service8/health" }
  , { serviceName: "service9", healthCheckEndpoint: "http:service9/health" }
  ]

healthCheckContent :: forall a. Widget HTML a
healthCheckContent =
  D.div
    [ operationsContentStyle ]
    (map buttonGroups healthCheckServices)
  where
  buttonGroups :: forall b. HealthCheckInfo -> Widget HTML b
  buttonGroups consumerService =
    D.div [ operationsButtonGroupsStyle ]
      [ D.h3' [ D.text consumerService.serviceName ]
      , D.button [ operationsButtonStyle "#04AA6D" ] [ D.text "Check Health" ]
      ]
