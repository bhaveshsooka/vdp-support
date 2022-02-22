module VDPSupport.Pages.OperationsPage
  ( operationsPage
  ) where

import Prelude
import Affjax as AX
import Affjax.ResponseFormat as ResponseFormat
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Data.Argonaut.Decode (class DecodeJson, decodeJson, (.:))
import Data.Array (cons)
import Data.Either (Either(..))
import Effect.Aff.Class (liftAff)
import VDPSupport.Styles (operationsButtonGroupsStyle, operationsButtonStyle, operationsContentStyle)
import VDPSupport.Topbar (TopbarAction(..), TopbarItem(..), TopbarItemArray, findActiveTab, getTopbarItem, topbarWidget, updateTabItems)

operationsPage :: forall a. Widget HTML a
operationsPage = operationsPage_ (Click activeItem) tabItems
  where
  activeItem :: TopbarItem
  activeItem = TopbarItem { name: "Consumer Restarts", active: true, hover: false }

  tabItems :: TopbarItemArray
  tabItems =
    cons activeItem
      [ TopbarItem { name: "Health Checks", active: false, hover: false }
      ]

operationsPage_ :: forall a. TopbarAction -> TopbarItemArray -> Widget HTML a
operationsPage_ currentAction currentTabItems = do
  newAction <-
    topbarWidget currentTabItems
      $ renderTabContent currentAction
      $ findActiveTab currentTabItems (getTopbarItem currentAction)
  let
    newTabItems = updateTabItems newAction currentTabItems
  operationsPage_ newAction newTabItems

renderTabContent :: TopbarAction -> TopbarItem -> Widget HTML TopbarAction
renderTabContent action activeItem = case action of
  Click (TopbarItem newItem) -> render' (TopbarItem newItem)
  _ -> render' activeItem
  where
  render' :: TopbarItem -> Widget HTML TopbarAction
  render' (TopbarItem item) = case item.name of
    "Consumer Restarts" -> consumerRestartsContent
    "Health Checks" -> healthCheckContent
    _ -> D.div' [ D.text "Unknown tab" ]

newtype ConsumerServiceInfo
  = ConsumerServiceInfo
  { marketName :: String
  , pauseEndpoint :: String
  , restartEndpoint :: String
  }

type ConsumerServiceInfoArray
  = Array ConsumerServiceInfo

instance decodeJsonConsumerServiceInfo :: DecodeJson ConsumerServiceInfo where
  decodeJson json = do
    obj <- decodeJson json
    mn <- obj .: "marketName"
    pe <- obj .: "pauseEndpoint"
    re <- obj .: "restartEndpoint"
    pure $ ConsumerServiceInfo { marketName: mn, pauseEndpoint: pe, restartEndpoint: re }

consumerRestartsContent ∷ forall a. Widget HTML a
consumerRestartsContent = do
  let
    url = "http://localhost:3000/vdp-services/consumers"
  res <- liftAff $ AX.get ResponseFormat.json url
  case res of
    Left err -> do
      D.div' [ D.text $ "GET " <> url <> " There was a problem making the request: " <> AX.printError err ]
    Right response -> do
      case decodeJson response.body of
        Right (r :: ConsumerServiceInfoArray) -> do
          D.div [ operationsContentStyle ] (map buttonGroups r)
        Left e -> do
          D.div' [ D.text $ "Can't parse JSON. : " <> show e ]
  where
  buttonGroups :: forall b. ConsumerServiceInfo -> Widget HTML b
  buttonGroups (ConsumerServiceInfo consumerService) =
    D.div [ operationsButtonGroupsStyle ]
      [ D.h3' [ D.text consumerService.marketName ]
      , D.button [ operationsButtonStyle "#aa0441" ] [ D.text "Pause" ]
      , D.button [ operationsButtonStyle "#04AA6D" ] [ D.text "Restart" ]
      ]

newtype HealthCheckInfo
  = HealthCheckInfo
  { serviceName :: String
  , healthCheckEndpoint :: String
  }

type HealthCheckInfoArray
  = Array HealthCheckInfo

instance decodeJsonHealthCheckInfo :: DecodeJson HealthCheckInfo where
  decodeJson json = do
    obj <- decodeJson json
    sn <- obj .: "serviceName"
    hce <- obj .: "healthCheckEndpoint"
    pure $ HealthCheckInfo { serviceName: sn, healthCheckEndpoint: hce }

healthCheckContent :: forall a. Widget HTML a
healthCheckContent = do
  let
    url = "http://localhost:3000/vdp-services/health-check-services"
  res <- liftAff $ AX.get ResponseFormat.json url
  case res of
    Left err -> do
      D.div' [ D.text $ "GET " <> url <> " There was a problem making the request: " <> AX.printError err ]
    Right response -> do
      case decodeJson response.body of
        Right (r :: HealthCheckInfoArray) -> do
          D.div [ operationsContentStyle ] (map buttonGroups r)
        Left e -> do
          D.div' [ D.text $ "Can't parse JSON. : " <> show e ]
  where
  buttonGroups :: forall b. HealthCheckInfo -> Widget HTML b
  buttonGroups (HealthCheckInfo consumerService) =
    D.div [ operationsButtonGroupsStyle ]
      [ D.h3' [ D.text consumerService.serviceName ]
      , D.button [ operationsButtonStyle "#04AA6D" ] [ D.text "Check Health" ]
      ]
