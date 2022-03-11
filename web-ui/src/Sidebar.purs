module VDPSupport.Sidebar where

import Prelude
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Control.Alt ((<|>))
import VDPSupport.Styles (sidebarItemStyle, sidebarStyle)

data SidebarItem
  = SidebarItem
    { name :: String
    , fontSize :: String
    , active :: Boolean
    }

data SidebarAction
  = Click SidebarItem

data SidebarInternalAction
  = Click'
  | Hover'
  | Unhover'

type SidebarItemArray
  = Array SidebarItem

sidebarWidget ::
  SidebarItemArray ->
  Widget HTML SidebarAction ->
  Widget HTML SidebarAction
sidebarWidget sidebarItems componentToRender =
  D.div
    [ sidebarStyle ]
    (map (renderSidebarItem false) sidebarItems)
    <|> D.div [ P.style { "marginLeft": "15.0%", "padding": "0px 10px" } ] [ componentToRender ]
  where
  renderSidebarItem :: Boolean -> SidebarItem -> Widget HTML SidebarAction
  renderSidebarItem hover (SidebarItem item) = do
    e <-
      D.a
        [ sidebarItemStyle item.fontSize item.active hover
        , P.onClick $> Click'
        , P.onMouseOver $> Hover'
        , P.onMouseLeave $> Unhover'
        ]
        [ D.text item.name ]
    case e of
      Hover' -> renderSidebarItem true $ (SidebarItem item)
      Unhover' -> renderSidebarItem false $ (SidebarItem item)
      Click' -> pure $ Click (SidebarItem item)

updateTabItems :: SidebarAction -> SidebarItemArray -> SidebarItemArray
updateTabItems a i = map (updateTabItem a) i

updateTabItem :: SidebarAction -> SidebarItem -> SidebarItem
updateTabItem actionedTab (SidebarItem existingItem) = case actionedTab of
  (Click (SidebarItem actionedItem)) ->
    if existingItem.name == actionedItem.name then
      SidebarItem $ existingItem { active = true }
    else
      SidebarItem $ existingItem { active = false }
