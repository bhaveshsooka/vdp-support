module VDPSupport.HTTP
  ( getContent
  , getRequest
  , postRequest
  )
  where

import Prelude
import Affjax (Error)
import Affjax as AX
import Affjax.RequestBody as RequestBody
import Affjax.ResponseFormat as ResponseFormat
import Affjax.ResponseHeader (ResponseHeader)
import Affjax.StatusCode (StatusCode)
import Data.Argonaut.Core (Json)
import Data.Argonaut.Decode (class DecodeJson, JsonDecodeError, decodeJson)
import Data.Argonaut.Encode (class EncodeJson, encodeJson)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Effect.Aff (Aff)
import Effect.Aff.Class (liftAff)

getContent :: forall a. DecodeJson a => String -> Aff (Either String a)
getContent url = do
  res <- (liftAff $ AX.get ResponseFormat.json url)
  case res of
    Left err -> pure $ Left $ "GET " <> url <> " There was a problem making the request: " <> AX.printError err
    Right response -> do
      case decodeJson response.body of
        Right r -> pure $ Right r
        Left (e :: JsonDecodeError) -> pure $ Left $ "Can't parse JSON. : " <> show e

getRequest ::
  String ->
  Aff
    ( Either Error
        { body :: Json
        , headers :: Array ResponseHeader
        , status :: StatusCode
        , statusText :: String
        }
    )
getRequest url = AX.get ResponseFormat.json url

postRequest ::
  forall requestPayload responsePayload.
  DecodeJson responsePayload =>
  EncodeJson requestPayload =>
  String -> requestPayload -> Aff (Either String responsePayload)
postRequest url body = do
  res <- (liftAff $ AX.post ResponseFormat.json url (Just $ RequestBody.json $ encodeJson body))
  case res of
    Left err -> pure $ Left $ "POST " <> url <> " There was a problem making the request: " <> AX.printError err
    Right response -> do
      case decodeJson response.body of
        Right r -> pure $ Right r
        Left (e :: JsonDecodeError) -> pure $ Left $ "Can't parse JSON. : " <> show e
