module Test.Pages.OperationsPage
  ( operationsPage
  ) where

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Test.Styles (operationsTopbarStyle)

operationsPage :: forall a. Widget HTML a
operationsPage =
  D.div'
    [ D.div [ operationsTopbarStyle ]
        []
    ]
