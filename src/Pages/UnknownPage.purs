module Test.Pages.UnknownPage where

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D

unknownPage :: forall a. Widget HTML a
unknownPage = D.div' [ D.text "UnknownPage"]
