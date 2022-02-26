module Games.SeteSeteSete(
    start
) where

import Control.Concurrent
import Control.Monad (Monad (return))
import Data.List (take)
import GHC.IO (unsafePerformIO)
import System.IO.Unsafe (unsafePerformIO)
import System.Random (randomRIO)

spinWheel :: [String]
spinWheel =
  let wheel = ["🍫", "🔔", "💩", "🍊", "🍒"]
   in unsafePerformIO $ do
        randomIndex1 <- randomRIO (0, 4 :: Int)
        randomIndex2 <- randomRIO (0, 4 :: Int)
        randomIndex3 <- randomRIO (0, 4 :: Int)
        return [wheel !! randomIndex1, wheel !! randomIndex2, wheel !! randomIndex3]

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
       in unsafePerformIO $ do
            printResult score wheels
            return $ bet + score

printResult :: Int -> [String] -> IO ()
printResult winnings wheels
  | winnings > 0 = putStrLn $ "Você ganhou " ++ show winnings ++ " com " ++ head wheels ++ " " ++ wheels !! 1 ++ " " ++ wheels !! 2 ++ "!"
  | otherwise = putStrLn $ "Você perdeu " ++ show winnings ++ " com " ++ head wheels ++ " " ++ wheels !! 1 ++ " " ++ wheels !! 2 ++ "!"

startGame :: Int -> IO ()
startGame bet = do
  putStrLn "Você quer jogar? (S/N)"
  answer <- getLine
  if answer == "S" || answer == "s"
    then do
      let winnings = playGame bet
      startGame winnings
    else print bet

start :: IO ()
start = do
  putStrLn "Bem Vindo ao Jogo 707070! Se Perder 70 de Novo!"
  putStrLn "        Você começa com $50 BetCoin!"
  putStrLn "-=-=-=-=-=-=-=-=-=-X><X-=-=-=-=-=-=-=-=-=-=-=-=-"
  putStrLn "Você ganha com a seguintes combinações:"
  putStrLn "1. 🍫     🍫    🍫         pays $250"
  putStrLn "2. 🔔     🔔    🔔    🍫   pays $20"
  putStrLn "3. 💩     💩    💩    🍫   pays $14"
  putStrLn "4. 🍊     🍊    🍊    🍫   pays $10"
  putStrLn "5. 🍒     🍒    🍒         pays $7"
  putStrLn "6. 🍒     🍒               pays $5"
  putStrLn "7. 🍒                      pays $2"
  startGame 50

convertToIOInt :: String -> IO Int
convertToIOInt input = do
  let inputInt = read input :: Int
  return inputInt