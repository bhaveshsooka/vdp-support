module VDPSupport.Topbar where

import Prelude
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Control.Alt ((<|>))
import VDPSupport.Styles (topbarItemStyle, topbarStyle)

newtype TopbarItem
  = TopbarItem
  { name :: String
  , active :: Boolean
  }

data TopbarAction
  = Click TopbarItem

data TopbarInternalAction
  = Click'
  | Hover'
  | Unhover'

type TopbarItemArray
  = Array TopbarItem

topbarWidget ::
  TopbarItemArray ->
  Widget HTML TopbarAction ->
  Widget HTML TopbarAction
topbarWidget tabs componentToRender =
  D.div
    [ topbarStyle ]
    (map (renderTopbarItem false) tabs)
    <|> componentToRender
  where
  renderTopbarItem :: Boolean -> TopbarItem -> Widget HTML TopbarAction
  renderTopbarItem hover (TopbarItem item) = do
    e <-
      D.a
        [ topbarItemStyle item.active hover
        , P.onClick $> Click'
        , P.onMouseOver $> Hover'
        , P.onMouseLeave $> Unhover'
        ]
        [ D.text item.name ]
    case e of
      Hover' -> renderTopbarItem true $ (TopbarItem item)
      Unhover' -> renderTopbarItem false $ (TopbarItem item)
      Click' -> pure $ Click (TopbarItem item)

updateTabItems :: TopbarAction -> TopbarItemArray -> TopbarItemArray
updateTabItems a i = map (updateTabItem a) i

updateTabItem :: TopbarAction -> TopbarItem -> TopbarItem
updateTabItem actionedTab (TopbarItem existingItem) = case actionedTab of
  (Click (TopbarItem actionedItem)) ->
    if existingItem.name == actionedItem.name then
      TopbarItem { name: existingItem.name, active: true }
    else
      TopbarItem { name: existingItem.name, active: false }
