module Test.Pages.ApplicationsPage where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D

applicationsPage :: forall a. Widget HTML a
applicationsPage = D.div' [ D.text $ "ApplicationsPage " ]
