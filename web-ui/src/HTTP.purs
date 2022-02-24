module VDPSupport.HTTP
  ( getContent
  )
  where

import Prelude

import Affjax as AX
import Affjax.ResponseFormat as ResponseFormat
import Data.Argonaut.Decode (class DecodeJson, JsonDecodeError, decodeJson)
import Data.Either (Either(..))
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