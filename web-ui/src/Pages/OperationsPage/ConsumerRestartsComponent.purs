module VDPSupport.Pages.OperationsPage.ConsumerRestartsComponent where

import Prelude

import Affjax.StatusCode (StatusCode(..))
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Control.Alt ((<|>))
import Data.Argonaut.Decode (decodeJson)
import Data.Either (Either(..))
import Effect.Aff.Class (liftAff)
import VDPSupport.HTTP (getRequest)
import VDPSupport.Pages.OperationsPage.Common (legendWidget, loadingIconWidget, noActionIconWidget, pauseIconWidget, refreshIconWidget, resumeIconWidget, serviceStatusWidget, tableWidget)
import VDPSupport.Pages.OperationsPage.Domain (ButtonClickAction, ConsumerServiceStatus(..), LegendItemArray, MarketInfoArray, flattenMarketInfoArray)
import VDPSupport.Pages.OperationsPage.Styles (pageStyle, tableHeadingsWidgetStyle)

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
  _ <- case result of
    Left _ -> loadPageFailedWidget
    Right response -> case decodeJson response.body of
      Left _ -> loadPageFailedWidget
      Right consumerRestartsServiceArray -> loadPageSuccessWidget consumerRestartsServiceArray
  consumerRestartsContent
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
consumerRestartsLegendWidget = (legendWidget "Legend" consumerRestartsLegendItems)

consumerRestartsTable :: MarketInfoArray -> Widget HTML ButtonClickAction
consumerRestartsTable marketInfoArray = tableWidget tableHeadingsWidget tableRowsWidget
  where
  tableHeadingsWidget =
    D.tr [ tableHeadingsWidgetStyle ]
      [ D.td' [ D.text "Market Name" ]
      , D.td' [ D.text "Environment" ]
      , D.td' [ D.text "IP Address" ]
      , D.td' [ D.text "Action" ]
      , D.td'
          [ D.text "Status"
          , refreshIconWidget "15px"
          ]
      ]

  tableRowsWidget = flattenMarketInfoArray marketInfoArray <#> tableRowWidget

  tableRowWidget consumerServiceInfo = do
    _ <-
      D.tr'
        [ D.td' [ D.text consumerServiceInfo.marketName ]
        , D.td' [ D.text consumerServiceInfo.environmentName ]
        , D.td' [ D.text consumerServiceInfo.ipAddress ]
        , D.td' [ tableCellActionIconWidget consumerServiceInfo ]
        , D.td' [ tableCellStatusWidget consumerServiceInfo.statusEndpoint ]
        ]
    tableRowWidget consumerServiceInfo

  tableCellActionIconWidget consumerServiceInfo = do
    serviceStatus <- consumerRestartsFetchStatus consumerServiceInfo.statusEndpoint <|> loadingIconWidget "25px"
    case serviceStatus of
      FailedToFetch -> noActionIconWidget "15px"
      Running -> pauseIconWidget consumerServiceInfo "15px"
      Paused -> resumeIconWidget consumerServiceInfo "15px"

  tableCellStatusWidget endpoint = do
    serviceStatus <- consumerRestartsFetchStatus endpoint <|> loadingIconWidget "25px"
    case serviceStatus of
      FailedToFetch -> refreshIconWidget "25px"
      Running -> serviceStatusWidget "Green"
      Paused -> serviceStatusWidget "Red"

consumerRestartsFetchStatus :: String -> Widget HTML ConsumerServiceStatus
consumerRestartsFetchStatus endpoint = do
  res <- (liftAff $ getRequest endpoint)
  case res of
    Left _ -> pure FailedToFetch
    Right r -> case r.status of
      (StatusCode 200) -> pure Running
      _ -> pure Paused
