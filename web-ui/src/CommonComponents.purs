module VDPSupport.CommonComponents where

import Prelude
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Control.Alt ((<|>))
import VDPSupport.Routing (Page(..), PageActions(..))
import VDPSupport.Styles (sidebarItemStyle, sidebarStyle)

sidebarWidget :: Widget HTML PageActions -> Widget HTML PageActions
sidebarWidget component =
  D.div [ sidebarStyle ]
    [ D.a [ sidebarItemStyle "40px", P.onClick $> (GotoPage HomePage) ] [ D.text "Menu" ]
    , D.a [ sidebarItemStyle "25px", P.onClick $> (GotoPage HomePage) ] [ D.text "Home" ]
    , D.a [ sidebarItemStyle "25px", P.onClick $> (GotoPage OperationsPage) ] [ D.text "Operations" ]
    , D.a [ sidebarItemStyle "25px", P.onClick $> (GotoPage InformationPage) ] [ D.text "Information" ]
    , D.a [ sidebarItemStyle "25px", P.onClick $> (GotoPage HelpPage) ] [ D.text "Help" ]
    ]
    <|> D.div [ P.style { "marginLeft": "15.0%", "padding": "0px 10px" } ] [ component ]
