module Main where

import Prelude

import Concur.React.Run (runWidgetInDom)
import Effect (Effect)
import Test.Routing (routingWidget)

main :: Effect Unit
main = runWidgetInDom "root" routingWidget
