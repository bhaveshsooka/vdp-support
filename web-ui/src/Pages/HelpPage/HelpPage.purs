module Test.Pages.HelpPage where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D

helpPage :: forall a. Widget HTML a
helpPage = D.div' [ D.text $ "HelpPage " ]
