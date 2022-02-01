module Test.Pages.OperationsPage
  ( operationsPage
  ) where

import Prelude
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Control.Alt ((<|>))
import Test.Pages.OperationsPage.OperationsPageTypes (MyTab(..), MyTabAction(..))
import Test.Styles (consumerRestartsButtonGroupsStyle, consumerRestartsButtonStyle, consumerRestartsContentStyle, operationsTopbarItemStyle, operationsTopbarStyle)

operationsPage :: forall a. MyTab -> MyTabAction -> Widget HTML a
operationsPage activeTab action = do
  selectedTab <-
    D.div [ operationsTopbarStyle ]
      [ D.a
          [ operationsTopbarItemStyle (ConsumerRestarts == activeTab) (action /= Click)
          , P.onClick $> Click
          -- , P.onMouseLeave $> Unhover
          -- , P.onMouseOver $> Hover
          ]
          [ D.text "Consumer Restarts" ]
          $> ConsumerRestarts
      , D.a
          [ operationsTopbarItemStyle (HealthChecks == activeTab) (action /= Click)
          , P.onClick $> Click
          -- , P.onMouseLeave $> Unhover
          -- , P.onMouseOver $> Hover
          ]
          [ D.text "Health Checks" ]
          $> HealthChecks
      ]
      <|> case activeTab of
          ConsumerRestarts -> consumerRestartsContent
          HealthChecks -> D.div' [ D.text "Health Checks Content" ]
  operationsPage selectedTab action

type ConsumerServiceInfo
  = { marketName :: String
    , pauseEndpoint :: String
    , restartEndpoint :: String
    }

consumerServices :: Array ConsumerServiceInfo
consumerServices =
  [ { marketName: "service1", pauseEndpoint: "http:service1/pause", restartEndpoint: "http:service1/restart" }
  , { marketName: "service2", pauseEndpoint: "http:service2/pause", restartEndpoint: "http:service2/restart" }
  , { marketName: "service3", pauseEndpoint: "http:service3/pause", restartEndpoint: "http:service3/restart" }
  , { marketName: "service4", pauseEndpoint: "http:service4/pause", restartEndpoint: "http:service4/restart" }
  , { marketName: "service5", pauseEndpoint: "http:service5/pause", restartEndpoint: "http:service5/restart" }
  , { marketName: "service6", pauseEndpoint: "http:service6/pause", restartEndpoint: "http:service6/restart" }
  , { marketName: "service7", pauseEndpoint: "http:service7/pause", restartEndpoint: "http:service7/restart" }
  , { marketName: "service8", pauseEndpoint: "http:service8/pause", restartEndpoint: "http:service8/restart" }
  , { marketName: "service9", pauseEndpoint: "http:service9/pause", restartEndpoint: "http:service9/restart" }
  ]

consumerRestartsContent :: forall a. Widget HTML a
consumerRestartsContent =
  D.div
    [ consumerRestartsContentStyle ]
    (map buttonGroups consumerServices)
  where
  buttonGroups :: forall b. ConsumerServiceInfo -> Widget HTML b
  buttonGroups consumerService =
    D.div [ consumerRestartsButtonGroupsStyle ]
      [ D.h3' [ D.text consumerService.marketName ]
      , D.button [ consumerRestartsButtonStyle "#aa0441" ] [ D.text "Pause" ]
      , D.button [ consumerRestartsButtonStyle "#04AA6D" ] [ D.text "Restart" ]
      ]
