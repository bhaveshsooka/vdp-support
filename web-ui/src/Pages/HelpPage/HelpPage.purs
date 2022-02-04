module Test.Pages.HelpPage where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Control.Alt ((<|>))
import Test.Pages.HelpPage.HelpPageTypes (MyTab(..), MyTabAction(..))
import Test.Styles (topbarItemStyle, topbarStyle)

helpPage :: forall a. MyTab -> MyTabAction -> Widget HTML a
helpPage activeTab action = do
  selectedTab <-
    D.div [ topbarStyle ]
      [ D.a
          [ topbarItemStyle (ArchitectureDiagrams == activeTab) (action == Hover)
          , P.onClick $> Click
          -- , P.onMouseLeave $> Unhover
          -- , P.onMouseOver $> Hover
          ]
          [ D.text "Architecture Diagrams" ]
          $> ArchitectureDiagrams
      , D.a
          [ topbarItemStyle (Walkthroughs == activeTab) (action == Hover)
          , P.onClick $> Click
          -- , P.onMouseLeave $> Unhover
          -- , P.onMouseOver $> Hover
          ]
          [ D.text "Walkthroughs" ]
          $> Walkthroughs
      ]
      <|> case activeTab of
          ArchitectureDiagrams -> D.text "ArchitectureDiagrams"
          Walkthroughs -> D.text "Walkthroughs"
  helpPage selectedTab action