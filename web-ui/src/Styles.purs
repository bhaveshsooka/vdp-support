module VDPSupport.Styles
  ( healthCheckLegendItemWidgetStyle
  , healthCheckLegendWidgetStyle
  , healthCheckStatusWidgetStyle
  , operationsButtonGroupsStyle
  , operationsButtonStyle
  , operationsContentStyle
  , setColor
  , sidebarItemStyle
  , sidebarStyle
  , tableStyle
  , topbarItemStyle
  , topbarStyle
  )
  where

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

operationsContentStyle :: forall a. P.ReactProps a
operationsContentStyle =
  P.style
    { "display": "flex"
    , "flexWrap": "wrap"
    , "justifyContent": "center"
    }

operationsButtonGroupsStyle :: forall a. P.ReactProps a
operationsButtonGroupsStyle =
  P.style
    { "flexGrow": "1"
    , "width": "20%"
    , "textAlign": "center"
    , "margin": "10px 10px"
    , "padding": "10px 0px"
    , "borderStyle": "double"
    }

operationsButtonStyle :: forall a. String -> P.ReactProps a
operationsButtonStyle color =
  P.style
    { "backgroundColor": color
    , "color": "white"
    , "padding": "20px"
    , "textAlign": "center"
    , "textDecoration": "none"
    , "display": "inline-block"
    , "fontSize": "16px"
    , "margin": "4px 2px"
    }

tableStyle :: forall a. P.ReactProps a
tableStyle =
  P.style
    { "width": "100%"
    , "border": "1px solid black"
    , "textAlign": "center"
    , "tableLayout": "fixed"
    , "marginBottom": "15px"
    , "borderCollapse": "collapse"
    }

healthCheckStatusWidgetStyle :: forall a. String -> P.ReactProps a
healthCheckStatusWidgetStyle color =
  P.style
    { "backgroundColor": color
    , "height": "25px"
    , "width": "25px"
    , "borderRadius": "50%"
    , "display": "inline-block"
    , "margin": "0px 10px"
    }

healthCheckLegendWidgetStyle :: forall a. P.ReactProps a
healthCheckLegendWidgetStyle =
  P.style
    { "border": "1px solid #000"
    , "display": "flex"
    , "justifyContent": "space-evenly"
    }

healthCheckLegendItemWidgetStyle :: forall a. P.ReactProps a
healthCheckLegendItemWidgetStyle =
  P.style
    { "display": "flex"
    , "alignItems": "center"
    , "justifyContent": "center"
    }

--------------------------------------------------------------------------------------------------
-- helper functions
--------------------------------------------------------------------------------------------------
setColor :: Boolean -> String -> String -> String
setColor active colTrue colFalse = if (active == true) then colTrue else colFalse
