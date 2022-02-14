module VDPSupport.Pages.OperationsPage.OperationsPageTypes
  ( MyTab(..)
  , MyTabAction(..)
  ) where

import Prelude

data MyTab
  = ConsumerRestarts
  | HealthChecks

instance eqMyTab :: Eq MyTab where
  eq ConsumerRestarts ConsumerRestarts = true
  eq HealthChecks HealthChecks = true
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
