module DB (
    insertPhase
) where

{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}

module Ourdb.Db where

import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import GHC.Int

data User = User {username :: String, score :: Int} deriving (Show, Read, Eq)

data Phase = Phase {sequencia :: String} deriving (Show, Read, Eq)

instance FromRow User where
  fromRow = User <$> field <*> field

instance FromRow Phase where
  fromRow = Phase <$> field

getUsers :: Connection -> IO [User]
getUsers conn = do
  query_ conn "SELECT username, score FROM users" :: IO [User]

getUsersFiveHighestScores :: Connection -> IO [User]
getUsersFiveHighestScores conn = do
  query_ conn "SELECT username, score FROM users ORDER BY score DESC LIMIT 5" :: IO [User]

insertUsernameAndUserScore :: Connection -> String -> Int -> IO ()
insertUsernameAndUserScore conn username score = do
  execute conn "INSERT INTO users (username, score) VALUES (?, ?)" (username, score)
  print username

insertPhase :: Connection -> Int -> String -> String -> IO ()
insertPhase conn id sequencia nivel = do
  execute conn "INSERT INTO phases (id, sequencia, nivel) VALUES (?, ?, ?)" (id, sequencia, nivel)
  print id

getPhase :: Connection -> IO [Phase]
getPhase conn = do
  query_ conn "SELECT phases.sequencia FROM phases WHERE id = (1)" :: IO [Phase]

connectOurDatabase :: IO ()
connectOurDatabase = do
  conn <- connectPostgreSQL "host='ec2-52-204-196-4.compute-1.amazonaws.com' port=5432 dbname='dchdcr7iap07pl' user='alxxpufsycowxx' password='ff89341db8b88bd30ae01f43290cbe396c7e3340fba82ebb52915b6a0f560998'"
  execute_ conn "CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, username VARCHAR(50) NOT NULL, score INTEGER NOT NULL)"
  execute_ conn "CREATE TABLE IF NOT EXISTS phases (id INTEGER PRIMARY KEY, sequencia VARCHAR(10) NOT NULL, nivel VARCHAR(10) NOT NULL)"
  print "Connected to database"

insertAllPhases :: Connection -> IO ()
insertAllPhases conn = do
  insertPhase conn 1 "aaswd" "facil"
