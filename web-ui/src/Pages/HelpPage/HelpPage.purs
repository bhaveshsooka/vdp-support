module VDPSupport.Pages.HelpPage
  ( helpPage
  ) where

import Prelude
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Data.Array (cons)
import VDPSupport.Topbar (TopbarAction(..), TopbarItem(..), TopbarItemArray, findActiveTab, getTopbarItem, topbarWidget, updateTabItems)

helpPage :: forall a. Widget HTML a
helpPage = helpPage_ (Click activeItem) tabItems
  where
  activeItem :: TopbarItem
  activeItem = TopbarItem { name: "Architecture Diagrams", active: true, hover: false }

  tabItems :: TopbarItemArray
  tabItems =
    cons activeItem
      [ TopbarItem { name: "Walkthroughs", active: false, hover: false }
      ]

helpPage_ :: forall a. TopbarAction -> TopbarItemArray -> Widget HTML a
helpPage_ currentAction currentTabItems = do
  newAction <-
    topbarWidget currentTabItems
      $ renderTabContent currentAction
      $ findActiveTab currentTabItems (getTopbarItem currentAction)
  let
    newTabItems = updateTabItems newAction currentTabItems
  helpPage_ newAction newTabItems

renderTabContent :: TopbarAction -> TopbarItem -> Widget HTML TopbarAction
renderTabContent action activeItem = case action of
  Click (TopbarItem newItem) -> render' (TopbarItem newItem)
  _ -> render' activeItem
  where
  render' :: TopbarItem -> Widget HTML TopbarAction
  render' (TopbarItem item) = case item.name of
    "Architecture Diagrams" -> D.text "ArchitectureDiagrams"
    "Walkthroughs" -> D.text "Walkthroughs"
    _ -> D.div' [ D.text "Unknown tab" ]
