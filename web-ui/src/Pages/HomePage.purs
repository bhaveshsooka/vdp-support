module VDPSupport.Pages.HomePage where

import Prelude
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import VDPSupport.Topbar (TopbarAction(..), TopbarItem(..), TopbarItemArray, findActiveTab, getItem, topbarWidget, updateTabItems)

homePage :: forall a. Widget HTML a
homePage = do
  homePage_ activeItem tabItems
  where
  activeItem :: TopbarAction
  activeItem = (Click $ TopbarItem { name: "section1", active: true, hover: false })

  tabItems :: TopbarItemArray
  tabItems =
    [ TopbarItem { name: "section1", active: true, hover: false }
    , TopbarItem { name: "section2", active: false, hover: false }
    , TopbarItem { name: "section3", active: false, hover: false }
    ]

homePage_ :: forall a. TopbarAction -> TopbarItemArray -> Widget HTML a
homePage_ currentAction currentTabItems = do
  newAction <-
    topbarWidget currentTabItems
      $ renderTabContent currentAction
      $ findActiveTab currentTabItems (getItem currentAction)
  let
    newTabItems = updateTabItems newAction currentTabItems
  homePage_ newAction newTabItems

renderTabContent :: TopbarAction -> TopbarItem -> Widget HTML TopbarAction
renderTabContent action activeItem = case action of
  Click (TopbarItem newItem) -> render' (TopbarItem newItem)
  _ -> render' activeItem
  where
  render' :: TopbarItem -> Widget HTML TopbarAction
  render' (TopbarItem item) = case item.name of
    "section1" -> D.div' [ D.text item.name ]
    "section2" -> D.div' [ D.text item.name ]
    "section3" -> D.div' [ D.text item.name ]
    _ -> D.div' [ D.text "Unknown tab" ]
