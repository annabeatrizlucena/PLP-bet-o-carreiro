{-# LANGUAGE OverloadedStrings #-}

import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.ToRow

saveUsernameAndScore :: Connection -> String -> Int -> IO ()
saveUsernameAndScore conn username score = do
  execute conn "INSERT INTO users (username, score) VALUES (?, ?)" (username, score)

savePhase :: Connection -> Int -> String -> IO()
savePhase conn id sequencia = do
  execute conn "INSERT INTO phases (id, sequencia) VALUES (?, ?)" (id, sequencia)


main :: IO ()
main = do
  conn <- connectPostgreSQL "host='ec2-3-227-195-74.compute-1.amazonaws.com' port=5432 dbname='da8upamdmubtlg' user='zwpjxbrwftjvcl' password='628983212b8777e7c19a04faec501c31df1881e8c7667c2f7a8606f2d39a93cb'"
  execute_ conn "CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, username VARCHAR(50) NOT NULL, score INTEGER NOT NULL)"
  print "Created table users"

  execute_ conn "CREATE TABLE IF NOT EXISTS phases (id INTEGER PRIMARY KEY, sequencia VARCHAR(10) NOT NULL)"
  print "Created table phases"
  

-- Host: ec2-3-227-195-74.compute-1.amazonaws.com
-- Database: da8upamdmubtlg
-- User: zwpjxbrwftjvcl
-- Password: 628983212b8777e7c19a04faec501c31df1881e8c7667c2f7a8606f2d39a93cb
-- Port: 5432
-- URI: postgres://zwpjxbrwftjvcl:628983212b8777e7c19a04faec501c31df1881e8c7667c2f7a8606f2d39a93cb@ec2-3-227-195-74.compute-1.amazonaws.com:5432/da8upamdmubtlg
-- Heroku CLI: heroku pg:psql postgresql-elliptical-88169 --app betocarrerodatabase
