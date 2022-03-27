module VDPSupport.Pages.OperationsPage.ConsumerRestartsComponent where

import Prelude
import Affjax.StatusCode (StatusCode(..))
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Control.Alt ((<|>))
import Data.Argonaut.Decode (decodeJson)
import Data.Array (concat)
import Data.Either (Either(..))
import Effect.Aff.Class (liftAff)
import VDPSupport.HTTP (getRequest)
import VDPSupport.Pages.OperationsPage.Common (confirmationDialogWidget, legendWidget, loadingIconWidget, noActionIconWidget, pauseIconWidget, refreshIconWidget, resumeIconWidget, serviceStatusWidget, tableWidget)
import VDPSupport.Pages.OperationsPage.Domain (ButtonClickAction(..), ConfirmDialogAction(..), ConsumerServiceStatus(..), LegendItemArray, MarketInfoArray)
import VDPSupport.Pages.OperationsPage.Styles (pageStyle)

-- Data
consumerRestartsLegendItems :: LegendItemArray
consumerRestartsLegendItems =
  [ { widget: serviceStatusWidget "Green", label: "Running" }
  , { widget: serviceStatusWidget "Red", label: "Paused" }
  , { widget: serviceStatusWidget "Purple", label: "Failed to fetch status" }
  ]

-- Main
consumerRestartsContent :: forall a. Widget HTML a
consumerRestartsContent = do
  let
    url = "http://localhost:3000/vdp-services/consumers"
  result <- (liftAff $ getRequest url) <|> D.div [ pageStyle ] [ loadingIconWidget "50px" ]
  action <- case result of
    Left _ -> loadPageFailedWidget
    Right response -> case decodeJson response.body of
      Left _ -> loadPageFailedWidget
      Right consumerRestartsServiceArray -> loadPageSuccessWidget consumerRestartsServiceArray
  case action of
    Refresh -> consumerRestartsContent
    PauseConsumer consumerService -> do
      confirmation <- confirmationDialogWidget $ "Confirm pause of " <> consumerService.ipAddress
      case confirmation of
        Confirm -> do
          consumerRestartsContent
        Cancel -> consumerRestartsContent
    ResumeConsumer consumerService -> do
      confirmation <- confirmationDialogWidget $ "Confirm resume of " <> consumerService.ipAddress
      case confirmation of
        Confirm -> do
          consumerRestartsContent
        Cancel -> consumerRestartsContent
  where
  loadPageFailedWidget =
    D.div [ pageStyle ]
      [ refreshIconWidget "50px" ]

  loadPageSuccessWidget consumerRestartsServiceArray =
    D.div [ pageStyle ]
      [ consumerRestartsTable consumerRestartsServiceArray
      , consumerRestartsLegendWidget
      ]

-- Helper
consumerRestartsLegendWidget :: forall a. Widget HTML a
consumerRestartsLegendWidget = (legendWidget "Color code" consumerRestartsLegendItems)

consumerRestartsTable :: MarketInfoArray -> Widget HTML ButtonClickAction
consumerRestartsTable marketInfoArray = tableWidget consumerRestartsTableHeadingsWidget consumerRestartsTableRowsWidget
  where
  consumerRestartsTableHeadingsWidget =
    D.tr'
      [ D.td' [ D.text "Market Name" ]
      , D.td' [ D.text "IP Address" ]
      , D.td' [ D.text "Action" ]
      , D.td'
          [ D.text "Status"
          , refreshIconWidget "15px"
          ]
      ]

  consumerRestartsTableRowsWidget =
    concat
      $ marketInfoArray
      <#> consumerRestartsTableMarketRowsWidget

  consumerRestartsTableMarketRowsWidget marketInfo =
    marketInfo.consumers
      <#> (consumerRestartsTableRowWidget marketInfo.marketName)

  consumerRestartsTableRowWidget marketName consumerServiceInfo = do
    D.tr'
      [ D.td' [ D.text marketName ]
      , D.td' [ D.text consumerServiceInfo.ipAddress ]
      , D.td' [ consumerRestartsActionIconWidget consumerServiceInfo ]
      , D.td' [ consumerRestartsStatusWidget consumerServiceInfo.statusEndpoint ]
      ]

  consumerRestartsActionIconWidget consumerServiceInfo = do
    serviceStatus <- (consumerRestartsFetchStatus consumerServiceInfo.statusEndpoint) <|> loadingIconWidget "25px"
    case serviceStatus of
      FailedToFetch -> noActionIconWidget "15px"
      Running -> pauseIconWidget consumerServiceInfo "15px"
      Paused -> resumeIconWidget consumerServiceInfo "15px"

  consumerRestartsStatusWidget endpoint = do
    serviceStatus <- (consumerRestartsFetchStatus endpoint) <|> loadingIconWidget "25px"
    _ <- case serviceStatus of
      FailedToFetch -> refreshIconWidget "25px"
      Running -> serviceStatusWidget "Green"
      Paused -> serviceStatusWidget "Red"
    consumerRestartsStatusWidget endpoint

  consumerRestartsFetchStatus endpoint = do
    res <- (liftAff $ getRequest endpoint)
    case res of
      Left _ -> pure FailedToFetch
      Right r -> case r.status of
        (StatusCode 200) -> pure Running
        _ -> pure Paused
