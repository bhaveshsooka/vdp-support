module Main where

import Prelude
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.Run (runWidgetInDom)
import Effect (Effect)
import Effect.Class (liftEffect)
import Foreign (unsafeToForeign)
import Routing.PushState (PushStateInterface, makeInterface)
import VDPSupport.Pages.HelpPage (helpPage)
import VDPSupport.Pages.HelpPage.HelpPageTypes as HelpPageTypes
import VDPSupport.Pages.HomePage (homePage)
import VDPSupport.Pages.InformationPage (informationPage)
import VDPSupport.Pages.InformationPage.InformationPageTypes as InformationPageTypes
import VDPSupport.Pages.NotFoundPage (notFoundPage)
import VDPSupport.Pages.OperationsPage (operationsPage)
import VDPSupport.Pages.OperationsPage.OperationsPageTypes as OperationsPageTypes
import VDPSupport.Routing (Page(..), PageActions(..), currentRoute, pageToRoute, parseRoute, printRoute, routeToPage)
import VDPSupport.CommonComponents (sidebarWidget)

renderPage :: Page -> Widget HTML PageActions
renderPage page = case page of
  HomePage -> homePage
  OperationsPage -> operationsPage OperationsPageTypes.ConsumerRestarts OperationsPageTypes.Click
  InformationPage -> informationPage InformationPageTypes.ServerIPs InformationPageTypes.Click
  HelpPage -> helpPage HelpPageTypes.ArchitectureDiagrams HelpPageTypes.Click
  NotFoundPage -> notFoundPage

changeInterface :: PushStateInterface -> Widget HTML PageActions -> Widget HTML PageActions
changeInterface interface component = do
  action <- component
  case action of
    GotoPage page -> do
      _ <- liftEffect $ interface.pushState (unsafeToForeign {}) (printRoute $ pageToRoute $ page)
      changeInterface interface component

main :: Effect Unit
main = do
  navInterface <- makeInterface
  _ <- navInterface.listen (\location -> render' navInterface $ parseRoute location.pathname)
  newRoute <- currentRoute
  render' navInterface newRoute
  where
  render' interface route =
    runWidgetInDom "root"
      $ changeInterface interface
      $ sidebarWidget
      $ renderPage
      $ routeToPage route
