module VDPSupport.Styles
  ( operationsButtonGroupsStyle
  , operationsButtonStyle
  , operationsContentStyle
  , sidebarItemStyle
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
    , "z-index": "1"
    , "top": "0"
    , "left": "0"
    , "background-color": "#111"
    , "overflow-x": "hidden"
    , "padding-top": "10px"
    }

sidebarItemStyle :: String -> forall a. P.ReactProps a
sidebarItemStyle fontSize =
  P.style
    { "padding": "6px 8px 6px 16px"
    , "text-decoration": "none"
    , "color": "#818181"
    , "display": "block"
    , "font-size": fontSize
    }

topbarStyle :: forall a. P.ReactProps a
topbarStyle =
  P.style
    { "background-color": "#333"
    , "overflow": "hidden"
    , "margin-bottom": "10px"
    }

topbarItemStyle :: forall a. Boolean -> Boolean -> P.ReactProps a
topbarItemStyle active hover =
  P.style
    { "float": "left"
    , "text-align": "center"
    , "padding": "14px 16px"
    , "text-decoration": "none"
    , "font-size": "17px"
    , "background-color": setColor active "#04AA6D" $ setColor hover "#ddd" "#333"
    , "color": setColor active "white" $ setColor hover "black" "#f2f2f2"
    }

operationsContentStyle :: forall a. P.ReactProps a
operationsContentStyle =
  P.style
    { "display": "flex"
    , "flex-wrap": "wrap"
    }

operationsButtonGroupsStyle :: forall a. P.ReactProps a
operationsButtonGroupsStyle =
  P.style
    { "flex-grow": "1"
    , "width": "20%"
    , "text-align": "center"
    , "margin": "10px 10px"
    , "padding": "10px 0px"
    , "border-style": "double"
    }

operationsButtonStyle :: forall a. String -> P.ReactProps a
operationsButtonStyle color =
  P.style
    { "background-color": color
    -- , "border": "none"
    , "color": "white"
    , "padding": "20px"
    , "text-align": "center"
    , "text-decoration": "none"
    , "display": "inline-block"
    , "font-size": "16px"
    , "margin": "4px 2px"
    , "border-radius": "50%"
    }

--------------------------------------------------------------------------------------------------
-- helper functions
--------------------------------------------------------------------------------------------------
setColor :: Boolean -> String -> String -> String
setColor active colTrue colFalse = if (active == true) then colTrue else colFalse
