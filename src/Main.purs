module Main where

import Prelude

import Concur.React.Run (runWidgetInDom)
import Effect (Effect)
import Test.Routing (routingWidget)

main :: Effect Unit
main = runWidgetInDom "root" routingWidget
  -- $ orr
  --   [ widget routingWidget "Routing"
  --   ]
  -- where
  --   widget w s =
  --     orr
  --       [ D.hr'
  --       , D.h2_ [] $ D.text s
  --       , D.div_ [] w
  --       ]
