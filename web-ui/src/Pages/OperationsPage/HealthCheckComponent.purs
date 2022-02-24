module VDPSupport.Pages.OperationsPage.HealthCheckComponent where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Control.Alt ((<|>))
import Data.Argonaut.Decode (class DecodeJson, decodeJson, (.:))
import Data.Either (Either(..))
import Effect.Aff.Class (liftAff)
import VDPSupport.HTTP (getContent)
import VDPSupport.Styles (operationsButtonGroupsStyle, operationsButtonStyle, operationsContentStyle)

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
  res <- (liftAff $ getContent url) <|> D.div [ operationsContentStyle ] [ D.text "Loading..." ]
  case res of
    Left err -> do
      D.div [ operationsContentStyle ] [ D.text err ]
    Right r -> do
      D.div [ operationsContentStyle ] (map buttonGroups r)
  where
  buttonGroups :: forall b. HealthCheckInfo -> Widget HTML b
  buttonGroups (HealthCheckInfo consumerService) =
    D.div [ operationsButtonGroupsStyle ]
      [ D.h3' [ D.text consumerService.serviceName ]
      , D.button [ operationsButtonStyle "#04AA6D" ] [ D.text "Check Health" ]
      ]

