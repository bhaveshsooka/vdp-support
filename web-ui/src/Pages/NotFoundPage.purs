module VDPSupport.Pages.NotFoundPage where

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D

notFoundPage :: forall a. Widget HTML a
notFoundPage = D.div' [ D.text "Page not found"]
