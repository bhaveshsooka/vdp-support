module Main
  ( main
  ) where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.Run (runWidgetInDom)
import Data.Array (cons)
import Effect (Effect)
import VDPSupport.Pages.HelpPage (helpPage)
import VDPSupport.Pages.HomePage (homePage)
import VDPSupport.Pages.InformationPage (informationPage)
import VDPSupport.Pages.NotFoundPage (notFoundPage)
import VDPSupport.Pages.OperationsPage (operationsPage)
import VDPSupport.Sidebar (SidebarAction(..), SidebarItem(..), SidebarItemArray, findActiveItem, getSidebarItem, sidebarWidget, updateTabItems)

----------------------------------------------------------------
-- Issue #1
-- Name         : Routing vs Event Handling
-- Description  : Cannot handle events and implement routing in the same solution
-- Solution     : On actionHandler for sidebar events, maintain tabItems as state (push/pop)
--
-- Issue #2
-- Name         : Component rendering - init state 
-- Description  : When a page is loaded it's initial state is 'hard-coded' and a resultant reset rendered view
-- Solution     : TabAction model needs to parameterize state
--
-- Issue #3
-- Name         : Too many HTTP calls
-- Description  : HTTP calls made on every action on the topbar + sidebar components
-- Solution     : ??
-- 
----------------------------------------------------------------
-- main :: Effect Unit
-- main = do
--   navInterface <- makeInterface

--   -- Listen to changes in url
--   _ <- navInterface.listen (\location -> renderMain navInterface (parseRoute location.pathname) tabItems) 

--   -- Get page we just landed on after url has changed
--   newRoute <- currentRoute

--   -- Rerender main 
--   renderMain navInterface newRoute tabItems
--   where
--   activeItem :: SidebarItem
--   activeItem = SidebarItem { name: "Home", fontSize: "25px", active: true, hover: false }

--   tabItems :: SidebarItemArray
--   tabItems =
--     cons activeItem
--       [ SidebarItem { name: "Operations", fontSize: "25px", active: false, hover: false }
--       , SidebarItem { name: "Information", fontSize: "25px", active: false, hover: false }
--       , SidebarItem { name: "Help", fontSize: "25px", active: false, hover: false }
--       ]

-- renderMain :: PushStateInterface -> Route -> SidebarItemArray -> Effect Unit
-- renderMain interface route tabItems =
--   runWidgetInDom "root"
--     $ sidebarActionHandler interface
--     $ sidebarWidget tabItems
--     $ renderPage
--     $ routeToPage route

-- sidebarActionHandler :: PushStateInterface -> Widget HTML SidebarAction -> Widget HTML SidebarAction
-- sidebarActionHandler interface component = do
--   action <- component  
--   case action of
--     Click item -> do
--       _ <- liftEffect $ interface.pushState (unsafeToForeign {}) (printRoute $ pageToRoute $ item)
--       sidebarActionHandler interface component
--     _ -> sidebarActionHandler interface component

-- renderPage :: SidebarItem -> Widget HTML SidebarAction
-- renderPage (SidebarItem item) = case item.name of
--   "Home" -> homePage
--   "Operations" -> operationsPage
--   "Information" -> informationPage
--   "Help" -> helpPage
--   _ -> notFoundPage

main :: Effect Unit
main = x
  where
  x = runWidgetInDom "root" $ renderMain

renderMain :: forall a. Widget HTML a
renderMain = renderMain_ (Click activeItem) tabItems
  where
  activeItem :: SidebarItem
  activeItem = SidebarItem { name: "Menu", fontSize: "40px", active: true, hover: false }
  tabItems :: SidebarItemArray
  tabItems =
    cons activeItem
      [ SidebarItem { name: "Home", fontSize: "25px", active: false, hover: false }
      , SidebarItem { name: "Operations", fontSize: "25px", active: false, hover: false }
      , SidebarItem { name: "Information", fontSize: "25px", active: false, hover: false }
      , SidebarItem { name: "Help", fontSize: "25px", active: false, hover: false }
      ]

renderMain_ :: forall a. SidebarAction -> SidebarItemArray -> Widget HTML a
renderMain_ currentAction currentTabItems = do
  newAction <-
    sidebarWidget currentTabItems
      $ renderPage currentAction
      $ findActiveItem currentTabItems (getSidebarItem currentAction)
  let
    newTabItems = updateTabItems newAction currentTabItems
  renderMain_ newAction newTabItems

renderPage :: SidebarAction -> SidebarItem -> Widget HTML SidebarAction
renderPage action activeItem = case action of
  Click (SidebarItem newItem) -> do
    render' $ SidebarItem newItem
  _ -> render' activeItem
  where
  render' :: SidebarItem -> Widget HTML SidebarAction
  render' (SidebarItem item) = case item.name of
    "Menu" -> homePage
    "Home" -> homePage
    "Operations" -> operationsPage
    "Information" -> informationPage
    "Help" -> helpPage
    _ -> notFoundPage
