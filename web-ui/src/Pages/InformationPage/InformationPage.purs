module VDPSupport.Pages.InformationPage where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Control.Alt ((<|>))
import VDPSupport.Pages.InformationPage.InformationPageTypes (MyTab(..), MyTabAction(..))
import VDPSupport.Styles (topbarItemStyle, topbarStyle)

informationPage :: forall a. MyTab -> MyTabAction -> Widget HTML a
informationPage activeTab action = do
  selectedTab <-
    D.div [ topbarStyle ]
      [ D.a
          [ topbarItemStyle (ServerIPs == activeTab) (action == Hover)
          , P.onClick $> Click
          -- , P.onMouseLeave $> Unhover
          -- , P.onMouseOver $> Hover
          ]
          [ D.text "Server IPs" ]
          $> ServerIPs
      , D.a
          [ topbarItemStyle (ApplicationsList == activeTab) (action == Hover)
          , P.onClick $> Click
          -- , P.onMouseLeave $> Unhover
          -- , P.onMouseOver $> Hover
          ]
          [ D.text "Applications List" ]
          $> ApplicationsList
      , D.a
          [ topbarItemStyle (FTPDirectories == activeTab) (action == Hover)
          , P.onClick $> Click
          -- , P.onMouseLeave $> Unhover
          -- , P.onMouseOver $> Hover
          ]
          [ D.text "FTP Directories" ]
          $> FTPDirectories
      , D.a
          [ topbarItemStyle (UsefulCommands == activeTab) (action == Hover)
          , P.onClick $> Click
          -- , P.onMouseLeave $> Unhover
          -- , P.onMouseOver $> Hover
          ]
          [ D.text "Useful Commands" ]
          $> UsefulCommands
      ]
      <|> case activeTab of
          ServerIPs -> D.text "ServerIPs"
          ApplicationsList -> D.text "ApplicationsList"
          FTPDirectories -> D.text "FTPDirectories"
          UsefulCommands -> D.text "UsefulCommands"
  informationPage selectedTab action