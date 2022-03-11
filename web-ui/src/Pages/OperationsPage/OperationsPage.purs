module VDPSupport.Pages.OperationsPage
  ( operationsPage
  ) where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Data.Array (cons)
import VDPSupport.Pages.OperationsPage.ConsumerRestartsComponent (consumerRestartsContent)
import VDPSupport.Pages.OperationsPage.HealthCheckComponent (healthCheckContent)
import VDPSupport.Topbar (TopbarAction(..), TopbarItem(..), TopbarItemArray, topbarWidget, updateTabItems)

operationsPage :: forall a. Widget HTML a
operationsPage = operationsPage_ (Click activeItem) tabItems
  where
  activeItem :: TopbarItem
  activeItem = TopbarItem { name: "Consumer Restarts", active: true }

  tabItems :: TopbarItemArray
  tabItems =
    cons activeItem
      [ TopbarItem { name: "Health Checks", active: false }
      ]

operationsPage_ :: forall a. TopbarAction -> TopbarItemArray -> Widget HTML a
operationsPage_ currentAction currentTabItems = do
  newAction <-
    topbarWidget currentTabItems
      $ renderTabContent currentAction
  let
    newTabItems = updateTabItems newAction currentTabItems
  operationsPage_ newAction newTabItems

renderTabContent :: TopbarAction -> Widget HTML TopbarAction
renderTabContent action = case action of
  Click (TopbarItem newItem) -> render' (TopbarItem newItem)
  -- _ -> render' activeItem
  where
  render' :: TopbarItem -> Widget HTML TopbarAction
  render' (TopbarItem item) = case item.name of
    "Consumer Restarts" -> consumerRestartsContent
    "Health Checks" -> healthCheckContent
    _ -> D.div' [ D.text "Unknown tab" ]
