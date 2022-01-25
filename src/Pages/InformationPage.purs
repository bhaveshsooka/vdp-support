module Test.Pages.InformationPage where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D

informationPage :: forall a. Widget HTML a
informationPage = D.div' [ D.text $ "InformationPage" ]
