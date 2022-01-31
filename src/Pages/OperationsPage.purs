module Test.Pages.OperationsPage
  ( MyTab(..)
  , MyTabAction(..)
  , operationsPage
  ) where

import Prelude
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Control.Alt ((<|>))
import Test.Styles (operationsTopbarItemStyle, operationsTopbarStyle)

data MyTab
  = ConsumerRestarts
  | HealthChecks

instance eqMyTab :: Eq MyTab where
  eq ConsumerRestarts ConsumerRestarts = true
  eq HealthChecks HealthChecks = true
  eq _ _ = false

data MyTabAction
  = Click
  | Hover
  | Unhover

instance eqMyTabAction :: Eq MyTabAction where
  eq Click Click = true
  eq Hover Hover = true
  eq Unhover Unhover = true
  eq _ _ = false

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
