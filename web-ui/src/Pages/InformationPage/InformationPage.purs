module VDPSupport.Pages.InformationPage where

import Prelude
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import VDPSupport.Topbar (TopbarAction(..), TopbarItem(..), TopbarItemArray, findActiveTab, getTopbarItem, topbarWidget, updateTabItems)

informationPage :: forall a. Widget HTML a
informationPage = informationPage_ activeItem tabItems
  where
  activeItem :: TopbarAction
  activeItem = (Click $ TopbarItem { name: "Server IPs", active: true, hover: false })

  tabItems :: TopbarItemArray
  tabItems =
    [ TopbarItem { name: "Server IPs", active: true, hover: false }
    , TopbarItem { name: "Applications List", active: false, hover: false }
    , TopbarItem { name: "FTP Directories", active: false, hover: false }
    , TopbarItem { name: "Useful Commands", active: false, hover: false }
    ]

informationPage_ :: forall a. TopbarAction -> TopbarItemArray -> Widget HTML a
informationPage_ currentAction currentTabItems = do
  newAction <-
    topbarWidget currentTabItems
      $ renderTabContent currentAction
      $ findActiveTab currentTabItems (getTopbarItem currentAction)
  let
    newTabItems = updateTabItems newAction currentTabItems
  informationPage_ newAction newTabItems

renderTabContent :: TopbarAction -> TopbarItem -> Widget HTML TopbarAction
renderTabContent action activeItem = case action of
  Click (TopbarItem newItem) -> render' (TopbarItem newItem)
  _ -> render' activeItem
  where
  render' :: TopbarItem -> Widget HTML TopbarAction
  render' (TopbarItem item) = case item.name of
    "Server IPs" -> D.text "Server IPs"
    "Applications List" -> D.text "ApplicationsList"
    "FTP Directories" -> D.text "FTPDirectories"
    "Useful Commands" -> D.text "UsefulCommands"
    _ -> D.div' [ D.text "Unknown tab" ]
