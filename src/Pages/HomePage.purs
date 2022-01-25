module Test.Pages.HomePage where

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D

homePage :: forall a. Widget HTML a
homePage = D.div' [ D.text "HomePage" ]
