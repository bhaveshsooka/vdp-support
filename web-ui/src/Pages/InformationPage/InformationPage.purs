module VDPSupport.Pages.InformationPage
  ( informationPage
  ) where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Data.Array (cons)
import VDPSupport.Topbar (TopbarAction(..), TopbarItem(..), TopbarItemArray, topbarWidget, updateTabItems)

informationPage :: forall a. Widget HTML a
informationPage = informationPage_ (Click activeItem) tabItems
  where
  activeItem :: TopbarItem
  activeItem = TopbarItem { name: "Server IPs", active: true }

  tabItems :: TopbarItemArray
  tabItems =
    cons activeItem
      [ TopbarItem { name: "Applications List", active: false }
      , TopbarItem { name: "FTP Directories", active: false }
      , TopbarItem { name: "Useful Commands", active: false }
      ]

informationPage_ :: forall a. TopbarAction -> TopbarItemArray -> Widget HTML a
informationPage_ currentAction currentTabItems = do
  newAction <-
    topbarWidget currentTabItems
      $ renderTabContent currentAction
  let
    newTabItems = updateTabItems newAction currentTabItems
  informationPage_ newAction newTabItems

renderTabContent :: TopbarAction -> Widget HTML TopbarAction
renderTabContent action = case action of
  Click (TopbarItem newItem) -> render' (TopbarItem newItem)
  where
  render' :: TopbarItem -> Widget HTML TopbarAction
  render' (TopbarItem item) = case item.name of
    "Server IPs" -> D.text "Server IPs"
    "Applications List" -> D.text "ApplicationsList"
    "FTP Directories" -> D.text "FTPDirectories"
    "Useful Commands" -> D.text "UsefulCommands"
    _ -> D.div' [ D.text "Unknown tab" ]
