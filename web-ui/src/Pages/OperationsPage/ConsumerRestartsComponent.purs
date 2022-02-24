module VDPSupport.Pages.OperationsPage.ConsumerRestartsComponent where

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
  res <- (liftAff $ getContent url) <|> D.div [ operationsContentStyle ] [ D.text "Loading..." ]
  case res of
    Left err -> do
      D.div [ operationsContentStyle ] [ D.text err ]
    Right r -> do
      D.div [ operationsContentStyle ] (map buttonGroups r)
  where
  buttonGroups :: forall b. ConsumerServiceInfo -> Widget HTML b
  buttonGroups (ConsumerServiceInfo consumerService) =
    D.div [ operationsButtonGroupsStyle ]
      [ D.h3' [ D.text consumerService.marketName ]
      , D.button [ operationsButtonStyle "#aa0441" ] [ D.text "Pause" ]
      , D.button [ operationsButtonStyle "#04AA6D" ] [ D.text "Restart" ]
      ]
