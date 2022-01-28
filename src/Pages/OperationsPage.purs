module Test.Pages.OperationsPage
  ( MyTab(..)
  , operationsPage
  )
  where

import Prelude
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Test.Styles (operationsTopbarItemStyle, operationsTopbarStyle)

data MyTab
  = ConsumerRestarts
  | HealthChecks

operationsPage :: forall a. MyTab -> Widget HTML a
operationsPage selectedTab = do
  newSelectedTab <-
    D.div'
      [ D.div [ operationsTopbarStyle ]
          [ D.button [ operationsTopbarItemStyle, P.onClick ] [ D.text "Consumer Restarts" ] $> ConsumerRestarts
          , D.button [ operationsTopbarItemStyle, P.onClick ] [ D.text "Health Checks" ] $> HealthChecks
          ]
      , case selectedTab of
          ConsumerRestarts -> D.div' [ D.text "Consumer Restarts Content" ]
          HealthChecks -> D.div' [ D.text "Health Checks Content" ]
      ]
  operationsPage newSelectedTab
