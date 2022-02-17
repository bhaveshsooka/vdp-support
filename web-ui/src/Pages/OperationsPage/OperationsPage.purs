module VDPSupport.Pages.OperationsPage
  ( operationsPage
  ) where

import Prelude
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Data.Argonaut.Core (Json)
import Data.Argonaut.Decode (class DecodeJson, JsonDecodeError, decodeJson, (.:))
import Data.Either (Either)
import Data.Traversable (traverse)
import VDPSupport.Styles (operationsButtonGroupsStyle, operationsButtonStyle, operationsContentStyle)
import VDPSupport.Topbar (TopbarAction(..), TopbarItem(..), TopbarItemArray, findActiveTab, getTopbarItem, topbarWidget, updateTabItems)

operationsPage :: forall a. Widget HTML a
operationsPage = operationsPage_ activeItem tabItems
  where
  activeItem :: TopbarAction
  activeItem = (Click $ TopbarItem { name: "Consumer Restarts", active: true, hover: false })

  tabItems :: TopbarItemArray
  tabItems =
    [ TopbarItem { name: "Consumer Restarts", active: true, hover: false }
    , TopbarItem { name: "Health Checks", active: false, hover: false }
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

decodeConsumerServiceInfoArray :: Json -> Either JsonDecodeError ConsumerServiceInfoArray
decodeConsumerServiceInfoArray json = decodeJson json >>= traverse decodeJson

consumerServices :: Array ConsumerServiceInfo
consumerServices =
  [ ConsumerServiceInfo { marketName: "market1", pauseEndpoint: "http:service1/pause", restartEndpoint: "http:service1/restart" }
  , ConsumerServiceInfo { marketName: "market2", pauseEndpoint: "http:service2/pause", restartEndpoint: "http:service2/restart" }
  , ConsumerServiceInfo { marketName: "market3", pauseEndpoint: "http:service3/pause", restartEndpoint: "http:service3/restart" }
  , ConsumerServiceInfo { marketName: "market4", pauseEndpoint: "http:service4/pause", restartEndpoint: "http:service4/restart" }
  , ConsumerServiceInfo { marketName: "market5", pauseEndpoint: "http:service5/pause", restartEndpoint: "http:service5/restart" }
  , ConsumerServiceInfo { marketName: "market6", pauseEndpoint: "http:service6/pause", restartEndpoint: "http:service6/restart" }
  , ConsumerServiceInfo { marketName: "market7", pauseEndpoint: "http:service7/pause", restartEndpoint: "http:service7/restart" }
  , ConsumerServiceInfo { marketName: "market8", pauseEndpoint: "http:service8/pause", restartEndpoint: "http:service8/restart" }
  , ConsumerServiceInfo { marketName: "market9", pauseEndpoint: "http:service9/pause", restartEndpoint: "http:service9/restart" }
  ]

consumerRestartsContent :: forall a. Widget HTML a
consumerRestartsContent =
  D.div
    [ operationsContentStyle ]
    (map buttonGroups consumerServices)
  where
  buttonGroups :: forall b. ConsumerServiceInfo -> Widget HTML b
  buttonGroups (ConsumerServiceInfo consumerService) =
    D.div [ operationsButtonGroupsStyle ]
      [ D.h3' [ D.text consumerService.marketName ]
      , D.button [ operationsButtonStyle "#aa0441" ] [ D.text "Pause" ]
      , D.button [ operationsButtonStyle "#04AA6D" ] [ D.text "Restart" ]
      ]

-- showData = (map buttonGroups fetchData)
-- fetchData = do
--   let
--     url = "http://localhost:3000/vdp-services/consumers"
--   httpResult <- (liftAff (AX.get ResponseFormat.json url)) <|> (D.text "Loading...")
--   case httpResult of
--     Left err -> D.text $ "GET " <> url <> " response failed: " <> AX.printError err
--     Right response ->
--       case (decodeConsumerServiceInfoArray response.body) of
--         Left err -> D.text ("Decode json error: " <> show err)
--         Right consumerServices -> map buttonGroups consumerServices
-- fetchData
-- fetchReddit :: forall a. String -> Widget HTML a
-- fetchReddit sub =
--   div'
--     [ h4' [ text ("/r/" <> sub) ]
--     , showPosts
--     ]
--   where
--   -- showPosts = button [onClick] [text "Fetch posts"] >>= \_ -> fetchPosts
--   fetchPosts = do
--     let
--       url = "http://localhost:3000/vdp-services/consumers"
--     result <- (liftAff (AX.get ResponseFormat.json url)) <|> (D.text "Loading...")
--     case result of
--       Left err -> D.text $ "GET " <> url <> " response failed to decode: " <> AX.printError err
--       Right response -> do
--         let
--           postsResp = do
--             o <- decodeJson response.body
--             d1 <- o .: "data"
--             cs <- d1 .: "children"
--             decodeConsumerServiceInfoArray cs
--         case postsResp of
--           Left err -> D.text ("Error: " <> show err)
--           Right posts -> do
--             D.div'
--               [ D.div' (map (\(Post p) -> div' [ text p.title ]) (take 5 posts))
--               , D.div' [ button [ unit <$ onClick ] [ text "Refresh" ] ]
--               ]
--             fetchPosts
newtype HealthCheckInfo
  = HealthCheckInfo
  { serviceName :: String
  , healthCheckEndpoint :: String
  }

healthCheckServices :: Array HealthCheckInfo
healthCheckServices =
  [ HealthCheckInfo { serviceName: "service1", healthCheckEndpoint: "http:service1/health" }
  , HealthCheckInfo { serviceName: "service2", healthCheckEndpoint: "http:service2/health" }
  , HealthCheckInfo { serviceName: "service3", healthCheckEndpoint: "http:service3/health" }
  , HealthCheckInfo { serviceName: "service4", healthCheckEndpoint: "http:service4/health" }
  , HealthCheckInfo { serviceName: "service5", healthCheckEndpoint: "http:service5/health" }
  , HealthCheckInfo { serviceName: "service6", healthCheckEndpoint: "http:service6/health" }
  , HealthCheckInfo { serviceName: "service7", healthCheckEndpoint: "http:service7/health" }
  , HealthCheckInfo { serviceName: "service8", healthCheckEndpoint: "http:service8/health" }
  , HealthCheckInfo { serviceName: "service9", healthCheckEndpoint: "http:service9/health" }
  ]

healthCheckContent :: forall a. Widget HTML a
healthCheckContent =
  D.div
    [ operationsContentStyle ]
    (map buttonGroups healthCheckServices)
  where
  buttonGroups :: forall b. HealthCheckInfo -> Widget HTML b
  buttonGroups (HealthCheckInfo consumerService) =
    D.div [ operationsButtonGroupsStyle ]
      [ D.h3' [ D.text consumerService.serviceName ]
      , D.button [ operationsButtonStyle "#04AA6D" ] [ D.text "Check Health" ]
      ]
