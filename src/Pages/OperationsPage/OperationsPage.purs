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
import Test.Styles (operationsTopbarItemStyle, operationsTopbarStyle)

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
          ConsumerRestarts -> D.div' [ D.text "Consumer Restarts Content" ]
          HealthChecks -> D.div' [ D.text "Health Checks Content" ]
  operationsPage selectedTab action
