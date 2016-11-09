{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad.IO.Class (liftIO)
import Web.Scotty (ScottyM)
import Data.Text.Lazy as TL
import qualified Web.Scotty as Scotty
import Actions (Token)
import qualified Actions
import qualified System.Exit as Exit
import qualified System.Environment as Env



port :: Int
port = 8080

main :: IO ()
main = do
  token <- getSlackToken
  Scotty.scotty port (routes token)

getSlackToken :: IO Token
getSlackToken = do
  maybeToken <- Env.lookupEnv envName
  case maybeToken of
    Nothing    -> Exit.die errorMessage
    Just token -> pure . TL.pack $ token
  where
  envName = "APP_SLACK_TOKEN"
  errorMessage = "Exiting process; Error: A slack token with admin scope must be supplied as an ENV variable called APP_SLACK_TOKEN."


-- Routes --

routes :: Token -> ScottyM ()
routes = join

join :: Token -> ScottyM ()
join token = Scotty.post "/join" $ do
  email <- Scotty.param "email"
  liftIO $ Actions.joinSlack token email
