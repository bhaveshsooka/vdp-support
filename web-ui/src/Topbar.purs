module VDPSupport.Topbar where

import Prelude
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Control.Alt ((<|>))
import Data.Array (filter, head)
import Data.Maybe (Maybe(..))
import VDPSupport.Styles (topbarItemStyle, topbarStyle)

newtype TopbarItem
  = TopbarItem
  { name :: String
  , active :: Boolean
  , hover :: Boolean
  }

data TopbarAction
  = Click TopbarItem
  | Hover TopbarItem
  | Unhover TopbarItem

getTopbarItem :: TopbarAction -> TopbarItem
getTopbarItem action = case action of
  (Click item) -> item
  (Hover item) -> item
  (Unhover item) -> item

type TopbarItemArray
  = Array TopbarItem

topbarWidget ::
  TopbarItemArray ->
  Widget HTML TopbarAction ->
  Widget HTML TopbarAction
topbarWidget tabs componentToRender =
  D.div
    [ topbarStyle ]
    (map renderTopbarItem tabs)
    <|> componentToRender
  where
  renderTopbarItem :: TopbarItem -> Widget HTML TopbarAction
  renderTopbarItem (TopbarItem item) =
    D.a
      [ topbarItemStyle (item.active) (item.hover)
      , P.onClick $> Click (TopbarItem item)
      , P.onMouseOver $> Hover (TopbarItem item)
      , P.onMouseLeave $> Unhover (TopbarItem item)
      ]
      [ D.text item.name ]

updateTabItems :: TopbarAction -> TopbarItemArray -> TopbarItemArray
updateTabItems a i = map (updateTabItem a) i

updateTabItem :: TopbarAction -> TopbarItem -> TopbarItem
updateTabItem actionedTab (TopbarItem existingItem) = case actionedTab of
  (Click (TopbarItem actionedItem)) ->
    if existingItem.name == actionedItem.name then
      TopbarItem { name: existingItem.name, active: true, hover: false }
    else
      TopbarItem { name: existingItem.name, active: false, hover: false }
  (Hover (TopbarItem actionedItem)) ->
    if existingItem.name == actionedItem.name then
      TopbarItem { name: existingItem.name, active: existingItem.active, hover: true }
    else
      TopbarItem { name: existingItem.name, active: existingItem.active, hover: false }
  (Unhover _) -> TopbarItem { name: existingItem.name, active: existingItem.active, hover: false }

findActiveTab :: TopbarItemArray -> TopbarItem -> TopbarItem
findActiveTab items (TopbarItem default) = case maybeItem of
  Just (TopbarItem i) -> TopbarItem i
  Nothing -> TopbarItem default
  where
  maybeItem = head $ filter (\(TopbarItem e) -> e.active == true) items
