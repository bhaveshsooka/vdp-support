module VDPSupport.Pages.HelpPage.HelpPageTypes
  ( MyTab(..)
  , MyTabAction(..)
  ) where

import Prelude

data MyTab
  = ArchitectureDiagrams
  | Walkthroughs

instance eqMyTab :: Eq MyTab where
  eq ArchitectureDiagrams ArchitectureDiagrams = true
  eq Walkthroughs Walkthroughs = true
  eq _ _ = false

data MyTabAction
  = Click
  | Hover
  | Unhover

instance eqMyTabAction :: Eq MyTabAction where
  eq Click Click = true
  eq Hover Hover = true
  eq Unhover Unhover = true
  eq _ _ = false
