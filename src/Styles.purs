module Test.Styles where

import Concur.React.Props (ReactProps)
import Concur.React.Props as P

sidebarStyle :: forall a. ReactProps a
sidebarStyle =
  P.style
    { "width": "15.0%"
    , "height": "100%"
    , "position": "fixed"
    , "z-index": "1"
    , "top": "0"
    , "left": "0"
    , "background-color": "#111"
    , "overflow-x": "hidden"
    , "padding-top": "20px"
    }

sidebarItemStyle :: String -> forall a. ReactProps a
sidebarItemStyle fontSize =
  P.style
    { "padding": "6px 8px 6px 16px"
    , "text-decoration": "none"
    , "color": "#818181"
    , "display": "block"
    , "font-size": fontSize
    }

operationsTopbarStyle :: forall a. ReactProps a
operationsTopbarStyle =
  P.style
    { "background-color": "#333"
    , "overflow": "hidden"
    }
