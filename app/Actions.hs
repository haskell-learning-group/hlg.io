{-# LANGUAGE OverloadedStrings #-}

module Actions where

import Data.Monoid ((<>))
import Control.Lens ((^.))
import Data.Text.Lazy (Text)
import qualified Data.Text.Lazy as Text
import Data.ByteString.Lazy (ByteString)
import qualified Data.ByteString.Lazy as LBS
import qualified Data.ByteString.Lazy.Char8 as LBChar8
import qualified Network.Wreq as HTTP
import qualified Web.Scotty as Server



type Email = Text



joinSlack :: Email -> IO ()
joinSlack email = do
  res <- HTTP.post (Text.unpack uri) nil
  LBChar8.putStrLn (res ^. HTTP.responseBody)
  where
  nil :: ByteString
  nil   = ""
  uri   = root <> "?email=" <> email <> "&token=" <> token
  root  = "https://slack.com/api/users.admin.invite"
  token = "TODO"
