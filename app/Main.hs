{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad.IO.Class (liftIO)
import Web.Scotty (ScottyM)
import qualified Web.Scotty as Scotty
import qualified Actions



port :: Int
port = 8080

main :: IO ()
main = Scotty.scotty port routes



-- Routes --

routes :: ScottyM ()
routes = join

join :: ScottyM ()
join = Scotty.post "/join" $ do
  email <- Scotty.param "email"
  liftIO $ Actions.joinSlack email
