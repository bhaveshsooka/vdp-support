module VDPSupport.Pages.OperationsPage.Styles where

import Concur.React.Props as P

legendWidgetStyle :: forall a. P.ReactProps a
legendWidgetStyle =
  P.style
    { "border": "1px solid #000"
    , "display": "flex"
    , "justifyContent": "space-evenly"
    }

legendItemWidgetStyle :: forall a. P.ReactProps a
legendItemWidgetStyle =
  P.style
    { "display": "flex"
    , "alignItems": "center"
    , "justifyContent": "center"
    }

iconStyle :: forall a. String -> P.ReactProps a
iconStyle size =
  P.style
    { "margin": "0px 5px"
    , "fontSize": size
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

serviceStatusWidgetStyle :: forall a. String -> P.ReactProps a
serviceStatusWidgetStyle color =
  P.style
    { "backgroundColor": color
    , "height": "25px"
    , "width": "25px"
    , "borderRadius": "50%"
    , "display": "inline-block"
    , "margin": "0px 10px"
    }

pageStyle :: forall a. P.ReactProps a
pageStyle =
  P.style
    { "display": "flex"
    , "flexWrap": "wrap"
    , "justifyContent": "center"
    }
