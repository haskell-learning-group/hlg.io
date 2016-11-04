{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty (ScottyM)
import Data.Monoid ((<>))
import Control.Monad.IO.Class (liftIO)
import qualified Web.Scotty as Server



port :: Int
port = 8080

main :: IO ()
main = Server.scotty port routes



-- Routes --

routes :: ScottyM ()
routes = join

join :: ScottyM ()
join = Server.post "/join" $ do
  message <- Server.param "message"
  liftIO . putStrLn $ "Client says: " <> message
