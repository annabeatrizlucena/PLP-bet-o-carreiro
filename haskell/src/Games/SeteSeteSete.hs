module Games.SeteSeteSete
  ( start,
  )
where

import Control.Concurrent
import Control.Monad (Monad (return))
import Data.List (take)
import Database.PostgreSQL.Simple.FromField (name)
import DatabasePostgre.DataPost
  ( conectToPostDatabase,
    insertUsernameAndUserScore,
  )
import GHC.IO (unsafePerformIO)
import System.IO.Unsafe (unsafePerformIO)
import System.Random

getRandomInteger :: (Int, Int) -> Int
getRandomInteger (a, b) = unsafePerformIO (randomRIO (a, b))

randomEmoji :: String
randomEmoji = do
  let i = getRandomInteger (0, 4)
  ["ð«", "ð", "ð©", "ð", "ð"] !! i

spinWheel :: [String]
spinWheel = [randomEmoji, randomEmoji, randomEmoji]

getScoreByWheels :: [String] -> Int
getScoreByWheels wheel
  | head wheel == "ð" && wheel !! 1 /= "ð" = 2
  | head wheel == "ð" && wheel !! 1 == "ð" && wheel !! 2 /= "ð" = 5
  | head wheel == "ð" && wheel !! 1 == "ð" && wheel !! 2 == "ð" = 7
  | head wheel == "ð" && wheel !! 1 == "ð" && (wheel !! 2 == "ð" || wheel !! 2 == "ð«") = 10
  | head wheel == "ð©" && wheel !! 1 == "ð©" && (wheel !! 2 == "ð©" || wheel !! 2 == "ð«") = 14
  | head wheel == "ð" && wheel !! 1 == "ð" && (wheel !! 2 == "ð" || wheel !! 2 == "ð«") = 20
  | head wheel == "ð«" && wheel !! 1 == "ð«" && wheel !! 2 == "ð«" = 250
  | otherwise = - 1

playGame :: Int -> Int
playGame bet =
  let wheels = spinWheel
   in let score = getScoreByWheels wheels
       in if score == -1
            then bet - 1
            else bet + score

printResult :: Int -> [String] -> IO ()
printResult winnings wheels
  | winnings > 0 = putStrLn $ "VocÃª Ganhou " ++ show winnings ++ " com " ++ head wheels ++ " " ++ wheels !! 1 ++ " " ++ wheels !! 2 ++ "!\n"
  | otherwise = putStrLn $ "VocÃª Perdeu " ++ show winnings ++ " com " ++ head wheels ++ " " ++ wheels !! 1 ++ " " ++ wheels !! 2 ++ "!\n"

startGame :: Int -> IO ()
startGame bet = do
  putStrLn "VocÃª Quer Jogar? (S/N)"
  answer <- getLine
  if answer == "S" || answer == "s"
    then do
      let newScore = playGame bet
      let winning = newScore - bet
      do
        printResult winning spinWheel
        startGame newScore
    else do
      putStrLn "Vamos Registar Seu Nome Para Salvar Suas Betcoins no Ranking ð"
      input <- getLine
      conn <- conectToPostDatabase
      insertUsernameAndUserScore conn input bet
      putStrLn $ "Seu score final foi de " ++ show bet ++ " betcoins. ð"

start :: IO ()
start = do
  putStrLn "Bem Vindo ao Jogo 707070! Se Perder 70 de Novo!"
  putStrLn "        VocÃª ComeÃ§a Com $50 BetCoins!"
  putStrLn "-=-=-=-=-=-=-=-=-=-X><X-=-=-=-=-=-=-=-=-=-=-=-=-"
  putStrLn "VocÃª Ganha Com as Seguintes CombinaÃ§Ãµes:"
  putStrLn "1. ð«     ð«    ð«         pays $250"
  putStrLn "2. ð     ð    ð    ð«   pays $20"
  putStrLn "3. ð©     ð©    ð©    ð«   pays $14"
  putStrLn "4. ð     ð    ð    ð«   pays $10"
  putStrLn "5. ð     ð    ð         pays $7"
  putStrLn "6. ð     ð               pays $5"
  putStrLn "7. ð                      pays $2"
  startGame 50