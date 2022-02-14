module Main where

import Prelude

import Concur.React.Run (runWidgetInDom)
import Effect (Effect)
import VDPSupport.Routing (routingWidget)

main :: Effect Unit
main = runWidgetInDom "root" routingWidget
