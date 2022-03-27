module VDPSupport.Styles
  ( sidebarItemStyle
  , sidebarStyle
  , topbarItemStyle
  , topbarStyle
  ) where

import Prelude
import Concur.React.Props as P

sidebarStyle :: forall a. P.ReactProps a
sidebarStyle =
  P.style
    { "width": "15.0%"
    , "height": "100%"
    , "position": "fixed"
    , "zIndex": "1"
    , "top": "0"
    , "left": "0"
    , "backgroundColor": "#111"
    , "overflowX": "hidden"
    , "paddingTop": "10px"
    }

sidebarItemStyle :: forall a. String -> Boolean -> Boolean -> P.ReactProps a
sidebarItemStyle fontSize active hover =
  P.style
    { "padding": "6px 8px 6px 16px"
    , "textDecoration": "none"
    , "display": "block"
    , "backgroundColor": "#111"
    , "color": setColor active "#04AA6D" $ setColor hover "white" "#818181"
    , "fontSize": fontSize
    }

topbarStyle :: forall a. P.ReactProps a
topbarStyle =
  P.style
    { "backgroundColor": "#333"
    , "overflow": "hidden"
    , "marginBottom": "30px"
    }

topbarItemStyle :: forall a. Boolean -> Boolean -> P.ReactProps a
topbarItemStyle active hover =
  P.style
    { "float": "left"
    , "textAlign": "center"
    , "padding": "14px 16px"
    , "textDecoration": "none"
    , "fontSize": "17px"
    , "backgroundColor": setColor active "#04AA6D" $ setColor hover "#ddd" "#333"
    , "color": setColor active "white" $ setColor hover "black" "#f2f2f2"
    }

--------------------------------------------------------------------------------------------------
-- helper functions
--------------------------------------------------------------------------------------------------
setColor :: Boolean -> String -> String -> String
setColor active colTrue colFalse = if (active == true) then colTrue else colFalse
