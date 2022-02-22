module VDPSupport.Sidebar
  ( SidebarAction(..)
  , SidebarItem(..)
  , SidebarItemArray
  , findActiveItem
  , getSidebarItem
  , sidebarWidget
  , updateTabItems
  ) where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Control.Alt ((<|>))
import Data.Array (filter, head)
import Data.Maybe (Maybe(..))
import Foreign (unsafeToForeign)
import Simple.JSON (class ReadForeign, class WriteForeign)
import Unsafe.Coerce (unsafeCoerce)
import VDPSupport.Styles (sidebarItemStyle, sidebarStyle)

data SidebarItem
  = SidebarItem
    { name :: String
    , fontSize :: String
    , active :: Boolean
    , hover :: Boolean
    }

data SidebarAction
  = Click SidebarItem
  | Hover SidebarItem
  | Unhover SidebarItem

type SidebarItemArray
  = Array SidebarItem

instance writeForeignSidebarItem :: WriteForeign SidebarItem where
  writeImpl (SidebarItem item) = unsafeToForeign item

instance readForeignSidebarItem :: ReadForeign SidebarItem where
  readImpl json = unsafeCoerce json

sidebarWidget ::
  SidebarItemArray ->
  Widget HTML SidebarAction ->
  Widget HTML SidebarAction
sidebarWidget sidebarItems componentToRender =
  D.div
    [ sidebarStyle ]
    (map renderSidebarItem sidebarItems)
    <|> D.div [ P.style { "marginLeft": "15.0%", "padding": "0px 10px" } ] [ componentToRender ]
  where
  renderSidebarItem :: SidebarItem -> Widget HTML SidebarAction
  renderSidebarItem (SidebarItem item) =
    D.a
      [ sidebarItemStyle item.fontSize item.active item.hover
      , P.onClick $> Click (SidebarItem item)
      , P.onMouseOver $> Hover (SidebarItem item)
      , P.onMouseLeave $> Unhover (SidebarItem item)
      ]
      [ D.text item.name ]

getSidebarItem :: SidebarAction -> SidebarItem
getSidebarItem action = case action of
  (Click item) -> item
  (Hover item) -> item
  (Unhover item) -> item

updateTabItems :: SidebarAction -> SidebarItemArray -> SidebarItemArray
updateTabItems a i = map (updateTabItem a) i

updateTabItem :: SidebarAction -> SidebarItem -> SidebarItem
updateTabItem actionedTab (SidebarItem existingItem) = case actionedTab of
  (Click (SidebarItem actionedItem)) ->
    if existingItem.name == actionedItem.name then
      SidebarItem $ existingItem { active = true, hover = false }
    else
      SidebarItem $ existingItem { active = false, hover = false }
  (Hover (SidebarItem actionedItem)) ->
    if existingItem.name == actionedItem.name then
      SidebarItem $ existingItem { hover = true }
    else
      SidebarItem $ existingItem { hover = false }
  (Unhover _) -> SidebarItem $ existingItem { hover = false }

findActiveItem :: SidebarItemArray -> SidebarItem -> SidebarItem
findActiveItem items (SidebarItem default) = case maybeItem of
  Just (SidebarItem i) -> SidebarItem i
  Nothing -> SidebarItem default
  where
  maybeItem = head $ filter (\(SidebarItem e) -> e.active == true) items
