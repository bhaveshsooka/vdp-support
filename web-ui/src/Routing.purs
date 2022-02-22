module VDPSupport.Routing
  ( Route(..)
  , currentRoute
  , pageToRoute
  , parseRoute
  , printRoute
  , routeToPage
  )
  where

import Prelude

import Data.Either (either)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Effect (Effect)
import Routing.Duplex (RouteDuplex', parse, path, print, root)
import Routing.Duplex.Generic (noArgs, sum)
import VDPSupport.Sidebar (SidebarItem(..))
import Web.HTML (window)
import Web.HTML.Location (pathname)
import Web.HTML.Window (location)

data Route
  = Home
  | Operations
  | Information
  | Help
  | NotFound

derive instance genericRoute :: Generic Route _

derive instance eqRoute :: Eq Route

derive instance ordRoute :: Ord Route

instance showRoute :: Show Route where
  show = genericShow

routes :: RouteDuplex' Route
routes =
  root
    $ sum
        { "Home": path "home" noArgs
        , "Operations": path "operations" noArgs
        , "Information": path "information" noArgs
        , "Help": path "help" noArgs
        , "NotFound": path "notfound" noArgs
        }

parseRoute :: String -> Route
parseRoute pathname = either (\_ -> NotFound) identity $ parse routes pathname

routeToPage :: Route -> SidebarItem
routeToPage route = case route of
  Home -> SidebarItem { name: "Home", fontSize: "40px", active: true, hover: false }
  Operations -> SidebarItem { name: "Operations", fontSize: "25px", active: false, hover: false }
  Information -> SidebarItem { name: "Information", fontSize: "25px", active: false, hover: false }
  Help -> SidebarItem { name: "Help", fontSize: "25px", active: false, hover: false }
  NotFound -> SidebarItem { name: "Unknown", fontSize: "25px", active: false, hover: false }

pageToRoute :: SidebarItem -> Route
pageToRoute (SidebarItem item) = case item.name of
  "Home" -> Home
  "Operations" -> Operations
  "Information" -> Information
  "Help" -> Help
  _ -> NotFound

printRoute :: Route -> String
printRoute = print routes

currentRoute :: Effect Route
currentRoute = do
  window >>= location >>= pathname <#> parseRoute
