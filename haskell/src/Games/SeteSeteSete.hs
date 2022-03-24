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
  ["🍫", "🔔", "💩", "🍊", "🍒"] !! i

spinWheel :: [String]
spinWheel = [randomEmoji, randomEmoji, randomEmoji]

getScoreByWheels :: [String] -> Int
getScoreByWheels wheel
  | head wheel == "🍒" && wheel !! 1 /= "🍒" = 2
  | head wheel == "🍒" && wheel !! 1 == "🍒" && wheel !! 2 /= "🍒" = 5
  | head wheel == "🍒" && wheel !! 1 == "🍒" && wheel !! 2 == "🍒" = 7
  | head wheel == "🍊" && wheel !! 1 == "🍊" && (wheel !! 2 == "🍊" || wheel !! 2 == "🍫") = 10
  | head wheel == "💩" && wheel !! 1 == "💩" && (wheel !! 2 == "💩" || wheel !! 2 == "🍫") = 14
  | head wheel == "🔔" && wheel !! 1 == "🔔" && (wheel !! 2 == "🔔" || wheel !! 2 == "🍫") = 20
  | head wheel == "🍫" && wheel !! 1 == "🍫" && wheel !! 2 == "🍫" = 250
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
  | winnings > 0 = putStrLn $ "Você Ganhou " ++ show winnings ++ " com " ++ head wheels ++ " " ++ wheels !! 1 ++ " " ++ wheels !! 2 ++ "!\n"
  | otherwise = putStrLn $ "Você Perdeu " ++ show winnings ++ " com " ++ head wheels ++ " " ++ wheels !! 1 ++ " " ++ wheels !! 2 ++ "!\n"

startGame :: Int -> IO ()
startGame bet = do
  putStrLn "Você Quer Jogar? (S/N)"
  answer <- getLine
  if answer == "S" || answer == "s"
    then do
      let newScore = playGame bet
      let winning = newScore - bet
      do
        printResult winning spinWheel
        startGame newScore
    else do
      putStrLn "Vamos Registar Seu Nome Para Salvar Suas Betcoins no Ranking 😊"
      input <- getLine
      conn <- conectToPostDatabase
      insertUsernameAndUserScore conn input bet
      putStrLn $ "Seu score final foi de " ++ show bet ++ " betcoins. 😊"

start :: IO ()
start = do
  putStrLn "Bem Vindo ao Jogo 707070! Se Perder 70 de Novo!"
  putStrLn "        Você Começa Com $50 BetCoins!"
  putStrLn "-=-=-=-=-=-=-=-=-=-X><X-=-=-=-=-=-=-=-=-=-=-=-=-"
  putStrLn "Você Ganha Com as Seguintes Combinações:"
  putStrLn "1. 🍫     🍫    🍫         pays $250"
  putStrLn "2. 🔔     🔔    🔔    🍫   pays $20"
  putStrLn "3. 💩     💩    💩    🍫   pays $14"
  putStrLn "4. 🍊     🍊    🍊    🍫   pays $10"
  putStrLn "5. 🍒     🍒    🍒         pays $7"
  putStrLn "6. 🍒     🍒               pays $5"
  putStrLn "7. 🍒                      pays $2"
  startGame 50