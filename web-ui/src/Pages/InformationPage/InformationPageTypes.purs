module VDPSupport.Pages.InformationPage.InformationPageTypes
  ( MyTab(..)
  , MyTabAction(..)
  ) where

import Prelude

data MyTab
  = ServerIPs
  | ApplicationsList
  | FTPDirectories
  | UsefulCommands

instance eqMyTab :: Eq MyTab where
  eq ServerIPs ServerIPs = true
  eq ApplicationsList ApplicationsList = true
  eq FTPDirectories FTPDirectories = true
  eq UsefulCommands UsefulCommands = true
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
