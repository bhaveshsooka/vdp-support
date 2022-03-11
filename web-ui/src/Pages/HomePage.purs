module VDPSupport.Pages.HomePage
  ( homePage
  ) where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Data.Array (cons)
import VDPSupport.Topbar (TopbarAction(..), TopbarItem(..), TopbarItemArray, topbarWidget, updateTabItems)

homePage :: forall a. Widget HTML a
homePage = homePage_ (Click activeItem) tabItems
  where
  activeItem :: TopbarItem
  activeItem = TopbarItem { name: "section1", active: true }

  tabItems :: TopbarItemArray
  tabItems =
    cons activeItem
      [ TopbarItem { name: "section2", active: false }
      , TopbarItem { name: "section3", active: false }
      ]

homePage_ :: forall a. TopbarAction -> TopbarItemArray -> Widget HTML a
homePage_ currentAction currentTabItems = do
  newAction <-
    topbarWidget currentTabItems
      $ renderTabContent currentAction
  let
    newTabItems = updateTabItems newAction currentTabItems
  homePage_ newAction newTabItems

renderTabContent :: TopbarAction -> Widget HTML TopbarAction
renderTabContent action = case action of
  Click (TopbarItem newItem) -> render' (TopbarItem newItem)
  where
  render' :: TopbarItem -> Widget HTML TopbarAction
  render' (TopbarItem item) = case item.name of
    "section1" -> D.div' [ D.text item.name ]
    "section2" -> D.div' [ D.text item.name ]
    "section3" -> D.div' [ D.text item.name ]
    _ -> D.div' [ D.text "Unknown tab" ]
