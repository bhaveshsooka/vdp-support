module VDPSupport.Routing
  ( Page(..)
  , PageActions(..)
  , Route(..)
  , currentRoute
  , pageToRoute
  , parseRoute
  , printRoute
  , routeToPage
  ) where

import Prelude
import Data.Either (either)
import Data.Generic.Rep (class Generic)
import Effect (Effect)
import Routing.Duplex (RouteDuplex', parse, path, print, root)
import Routing.Duplex.Generic (noArgs, sum)
import Web.HTML (window)
import Web.HTML.Location (pathname)
import Web.HTML.Window (location)

data Page
  = HomePage
  | OperationsPage
  | InformationPage
  | HelpPage
  | NotFoundPage

data PageActions
  = GotoPage Page

derive instance genericRoute :: Generic Route _

data Route
  = Home
  | Operations
  | Information
  | Help
  | NotFound

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

routeToPage :: Route -> Page
routeToPage route = case route of
  Home -> HomePage
  Operations -> OperationsPage
  Information -> InformationPage
  Help -> HelpPage
  NotFound -> NotFoundPage

pageToRoute :: Page -> Route
pageToRoute page = case page of
  HomePage -> Home
  OperationsPage -> Operations
  InformationPage -> Information
  HelpPage -> Help
  NotFoundPage -> NotFound

printRoute :: Route -> String
printRoute = print routes

currentRoute :: Effect Route
currentRoute = do
  window >>= location >>= pathname <#> parseRoute
