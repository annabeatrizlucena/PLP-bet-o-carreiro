{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}

module DatabasePostgre.DataPost where

import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import GHC.Int

data User = User {username :: String, score :: Int} deriving (Show, Read, Eq)

instance FromRow User where
  fromRow = User <$> field <*> field

getUsers :: Connection -> IO [User]
getUsers conn = do
  query_ conn "SELECT username, score FROM users" :: IO [User]

getUsersFiveHighestScores :: Connection -> IO [User]
getUsersFiveHighestScores conn = do
  query_ conn "SELECT username, score FROM users ORDER BY score DESC LIMIT 5" :: IO [User]

insertUsernameAndUserScore :: Connection -> String -> Int -> IO ()
insertUsernameAndUserScore conn username score = do
  execute conn "INSERT INTO users (username, score) VALUES (?, ?)" (username, score)
  putStrLn ""

createTables :: Connection -> IO ()
createTables conn = do
  execute_ conn "CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, username VARCHAR(50) NOT NULL, score INTEGER NOT NULL)"
  print "Table created"

conectToPostDatabase :: IO Connection
conectToPostDatabase = do
  conn <- connectPostgreSQL "host='ec2-52-204-196-4.compute-1.amazonaws.com' port=5432 dbname='dchdcr7iap07pl' user='alxxpufsycowxx' password='ff89341db8b88bd30ae01f43290cbe396c7e3340fba82ebb52915b6a0f560998'"
  putStrLn ""
  return conn
