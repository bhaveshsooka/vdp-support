module VDPSupport.Pages.OperationsPage.HealthCheckComponent
  ( healthCheckContent
  ) where

import Prelude

import Affjax.StatusCode (StatusCode(..))
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Control.Alt ((<|>))
import Data.Argonaut.Decode (class DecodeJson, decodeJson, (.:))
import Data.Array (cons)
import Data.Either (Either(..))
import Effect.Aff.Class (liftAff)
import VDPSupport.HTTP (getRequest)
import VDPSupport.Styles (healthCheckLegendItemWidgetStyle, healthCheckLegendWidgetStyle, operationsContentStyle, healthCheckStatusWidgetStyle, tableStyle)

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
  result <- (liftAff $ getRequest url) <|> D.div [ operationsContentStyle ] [ healthCheckLoadingIcon "50px" ]
  _ <- case result of
    Left _ -> D.div [ operationsContentStyle ] [ healthCheckRefreshButton "50px" ]
    Right response -> case decodeJson response.body of
      Left _ -> D.div [ operationsContentStyle ] [ healthCheckRefreshButton "50px" ]
      Right healthCheckServiceArray ->
        D.table [ tableStyle ]
          [ D.tbody' (cons tableHeadingsWidget (map healthCheckTableRowWidget healthCheckServiceArray))
          ]
          <|> healthCheckLegendWidget
  healthCheckContent
  where
  tableHeadingsWidget =
    D.tr'
      [ D.td' [ D.text "Service Name" ]
      , D.td'
          [ D.text "Status"
          , healthCheckRefreshButton "15px"
          ] 
      ]
  healthCheckRefreshButton size = D.i [ P.className "fa fa-refresh", P.style { "margin": "0px 5px", "fontSize": size }, P.onClick ] []

healthCheckLoadingIcon :: forall a. String -> Widget HTML a
healthCheckLoadingIcon size = D.i [ P.className "fa fa-refresh fa-spin", P.style { "margin": "0px 5px", "fontSize": size } ] []

healthCheckLegendWidget :: forall a. Widget HTML a
healthCheckLegendWidget =
  D.fieldset [ healthCheckLegendWidgetStyle ]
    [ D.legend' [ D.text "Color code" ]
    , healthCheckLegendItemWidget "Green" "Healthy"
    , healthCheckLegendItemWidget "Red" "Unhealthy"
    , healthCheckLegendItemWidget "Purple" "Failed to fetch status"
    ]
  where
  healthCheckLegendItemWidget color legendLabel =
    D.div
      [ healthCheckLegendItemWidgetStyle ]
      [ healthCheckStatusWidget color
      , D.label' [ D.text legendLabel ]
      ]

healthCheckTableRowWidget :: forall a. HealthCheckInfo -> Widget HTML a
healthCheckTableRowWidget (HealthCheckInfo healthCheckService) =
  D.tr'
    [ D.td' [ D.text healthCheckService.serviceName ]
    , healthCheckFetchStatusWidget healthCheckService.healthCheckEndpoint
    ]

healthCheckFetchStatusWidget :: forall a. String -> Widget HTML a
healthCheckFetchStatusWidget endpoint = do
  res <- (liftAff $ getRequest endpoint) <|> healthCheckLoadingIcon "25px"
  case res of
    Left _ -> serviceStatusTableCellWidget "Purple"
    Right r -> case r.status of
      (StatusCode 200) -> serviceStatusTableCellWidget "Green"
      _ -> serviceStatusTableCellWidget "Red"
  where
  serviceStatusTableCellWidget color = D.td' [ healthCheckStatusWidget color ]

healthCheckStatusWidget :: forall a. String -> Widget HTML a
healthCheckStatusWidget color = D.span [ healthCheckStatusWidgetStyle color ] []
