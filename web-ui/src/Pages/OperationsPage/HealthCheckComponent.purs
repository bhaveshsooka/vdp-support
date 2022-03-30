module VDPSupport.Pages.OperationsPage.HealthCheckComponent
  ( healthCheckContent
  ) where

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
import VDPSupport.Pages.OperationsPage.Common (legendWidget, loadingIconWidget, refreshIconWidget, serviceStatusWidget, tableWidget)
import VDPSupport.Pages.OperationsPage.Domain (ButtonClickAction, HealthCheckInfoArray, LegendItemArray)
import VDPSupport.Pages.OperationsPage.Styles (pageStyle, tableHeadingsWidgetStyle)

-- Data
healthCheckLegendItems :: LegendItemArray
healthCheckLegendItems =
  [ { widget: serviceStatusWidget "Green", label: "Healthy" }
  , { widget: serviceStatusWidget "Red", label: "Unhealthy" }
  , { widget: serviceStatusWidget "Purple", label: "Failed to fetch status" }
  ]

-- Main
healthCheckContent :: forall a. Widget HTML a
healthCheckContent = do
  let
    url = "http://localhost:3000/vdp-services/health-check-services"
  result <- (liftAff $ getRequest url) <|> D.div [ pageStyle ] [ loadingIconWidget "50px" ]
  _ <- case result of
    Left _ -> loadPageFailedWidget
    Right response -> case decodeJson response.body of
      Left _ -> loadPageFailedWidget
      Right healthCheckServiceArray -> loadPageSuccessWidget healthCheckServiceArray
  healthCheckContent
  where
  loadPageFailedWidget =
    D.div [ pageStyle ]
      [ refreshIconWidget "50px" ]

  loadPageSuccessWidget healthCheckServiceArray =
    D.div [ pageStyle ]
      [ healthCheckStatusTable healthCheckServiceArray
      , healthCheckLegendWidget
      ]

-- Helper
healthCheckLegendWidget :: forall a. Widget HTML a
healthCheckLegendWidget = (legendWidget "Legend" healthCheckLegendItems)

healthCheckStatusTable :: HealthCheckInfoArray -> Widget HTML ButtonClickAction
healthCheckStatusTable healthCheckServiceArray = tableWidget healthCheckTableHeadingsWidget healthCheckTableRowsWidget
  where
  healthCheckTableHeadingsWidget =
    D.tr [ tableHeadingsWidgetStyle ]
      [ D.td' [ D.text "Service Name" ]
      , D.td'
          [ D.text "Status"
          , refreshIconWidget "15px"
          ]
      ]

  healthCheckTableRowsWidget = (map healthCheckTableRowWidget healthCheckServiceArray)

  healthCheckTableRowWidget healthCheckService =
    D.tr'
      [ D.td' [ D.text healthCheckService.serviceName ]
      , D.td' [ healthCheckFetchStatusWidget healthCheckService.healthCheckEndpoint ]
      ]

  healthCheckFetchStatusWidget endpoint = do
    res <- (liftAff $ getRequest endpoint) <|> loadingIconWidget "25px"
    _ <- case res of
      Left _ -> refreshIconWidget "25px" -- D.td' [ serviceStatusWidget "Purple" ] -- revert this to remove individual refreshes
      Right r -> case r.status of
        (StatusCode 200) -> serviceStatusWidget "Green"
        _ -> serviceStatusWidget "Red"
    healthCheckFetchStatusWidget endpoint
