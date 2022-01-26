module Test.Routing
  ( routingWidget
  ) where

import Prelude (bind, discard, pure, void, ($), (*>), (<$), (<*))
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Control.Alt ((<|>))
import Data.Foldable (oneOf)
import Effect.AVar as Evar
import Effect.Aff (Milliseconds(..), delay)
import Effect.Aff.AVar as Avar
import Effect.Aff.Class (liftAff)
import Effect.Class (liftEffect)
import Routing.Hash (matches)
import Routing.Match (Match, end, lit, root)
import Test.Pages.HelpPage (helpPage)
import Test.Pages.HomePage (homePage)
import Test.Pages.InformationPage (informationPage)
import Test.Pages.OperationsPage (operationsPage)
import Test.Pages.UnknownPage (unknownPage)
import Test.Styles (sidebarItemStyle, sidebarStyle)

-- To route, we start listening for route changes with `matches`
-- On each route change we push the route to a var
-- Then we listen on the var asynchronously from within the UI with `awaitRoute`
routingWidget :: forall a. Widget HTML a
routingWidget = do
  routeRef <-
    liftEffect
      $ do
          var <- Evar.empty
          void $ matches myRoutes \_ route -> void $ Evar.tryPut route var
          pure var
  let
    awaitRoute = liftAff $ Avar.take routeRef
  -- HACK: This delay is only needed the first time
  -- Since the page might still be loading,
  -- and there are weird interactions between loading the homepage and the current route
  liftAff (delay (Milliseconds 0.0))
  sidebar <|> D.div [ P.style { "margin-left": "15.0%", "padding": "0px 10px" } ] [ go awaitRoute HomePage ]
  where
  go awaitRoute route = do
    route' <- awaitRoute <|> pageForRoute route
    go awaitRoute route'

-- Route and associated pages
data MyRoute
  = HomePage
  | OperationsPage
  | InformationPage
  | HelpPage
  | UnknownPage

myRoutes :: Match MyRoute
myRoutes =
  root
    *> oneOf
        [ HomePage <$ end
        , OperationsPage <$ lit "operations" <* end
        , InformationPage <$ lit "info" <* end
        , HelpPage <$ lit "help" <* end
        ]

pageForRoute :: forall a. MyRoute -> Widget HTML a
pageForRoute HomePage = homePage

pageForRoute OperationsPage = operationsPage

pageForRoute InformationPage = informationPage

pageForRoute HelpPage = helpPage

pageForRoute _ = unknownPage

sidebar :: forall a. Widget HTML a
sidebar =
  D.div [ sidebarStyle ]
    [ D.a [ sidebarItemStyle "40px", P.href "#/" ] [ D.text "Menu" ]
    , D.a [ sidebarItemStyle "25px", P.href "#/" ] [ D.text "Home" ]
    , D.a [ sidebarItemStyle "25px", P.href "#/operations" ] [ D.text "Operations" ]
    , D.a [ sidebarItemStyle "25px", P.href "#/info" ] [ D.text "Information" ]
    , D.a [ sidebarItemStyle "25px", P.href "#/help" ] [ D.text "Help" ]
    ]
