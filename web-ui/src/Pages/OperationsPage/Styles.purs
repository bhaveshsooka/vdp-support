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

tableWidgetStyle :: forall a. P.ReactProps a
tableWidgetStyle =
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

confirmationDialogWidgetStyle :: forall a. P.ReactProps a
confirmationDialogWidgetStyle =
  P.style
    { "display": "block"
    , "position": "fixed"
    , "zIndex": "1"
    , "paddingTop": "100px"
    , "paddingLeft": "25%"
    , "left": "0"
    , "top": "0"
    , "width": "100%"
    , "height": "100%"
    , "textAlign": "center"
    , "overflow": "auto"
    , "backgroundColor": "rgb(0, 0, 0, 0.4)"
    }

confirmationDialogContentWidgetStyle :: forall a. P.ReactProps a
confirmationDialogContentWidgetStyle =
  P.style
    { "backgroundColor": "#fefefe"
    , "marginLeft": "15%"
    , "padding": "20px"
    , "border": "1px solid #888"
    , "width": "30%"
    }

buttonStyle :: forall a. String -> P.ReactProps a
buttonStyle color =
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
