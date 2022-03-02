module Games.Setas (
    initArrowsGame
) where

import Control.Concurrent
import Control.Monad (liftM)
import System.IO.Unsafe (unsafePerformIO)
import System.Random (Random (randomR), getStdRandom)
import System.Timeout
import qualified System.Process as SP
import Util.Shuffle (shuffle)

clearScreen :: IO ()
clearScreen = do
  _ <- SP.system "reset"
  return ()

printSpace :: IO ()
printSpace = do
  putStr "\n"

checkSequence :: String -> String -> IO()
checkSequence expected answer = do
  if expected == answer
    then print "RESPOSTA CORRETA! :)"
    else print "RESPOSTA INCORRETA :("
  
printCharacter :: String -> IO ()
printCharacter string = do
  if not (null string)
    then do
      print (head string)
      Control.Concurrent.threadDelay 1000000
      printCharacter (drop 1 string)
    else do
      clearScreen
      
getSequenceEasy :: String 
getSequenceEasy = do
    -- let aleatoryNumber = getAleatoryNumber 0 14
    let easyList = ["aaswd","aaswd","wdsaw","swdaa","dwsdd","wswaa","dsaws","sswda","sdaws","ddasw","awsdw","sadws","dawsw","sawds","awdsa","wasda"]
    return (shuffle easyList)!!0
    -- easyList!!aleatoryNumber 

getSequenceMiddle :: String 
getSequenceMiddle = do
    -- let aleatoryNumber = getAleatoryNumber 0 14
    let middleList = ["wdsaawd","awdswsd","wsadwsd","awsdwsd","awaaaws","dsadwsw","swdsadw","dswaswd","wsaswsw","awswwwd","dawdwsd","wsdawsw","awaawwd","ssadwsw","asdwswa"]
    return (shuffle easyList)!!0
    -- middleList!!aleatoryNumber 

getSequenceHard :: String 
getSequenceHard = do
    -- let aleatoryNumber = getAleatoryNumber 0 14
    let hardList = ["asswswsdsa","sdwasdwsas","wswsswddsa","daswswsdsa","sdaswsawsd","swddswssaw","dwsawsawds","asdaswssws","sawdwsadsd","sawdswswsd","wasdwsswds","wswsdwswsw","asddsaswas","dsdsswasds","sawsdwsasd"]
    return (shuffle easyList)!!0
    -- hardList!!aleatoryNumber


-- getAleatoryNumber :: Int -> Int -> Int
-- {-# NOINLINE getAleatoryNumber #-}
-- getAleatoryNumber first end = unsafePerformIO (getStdRandom (randomR (first, end)))

getInput :: String -> IO ()
getInput seq = do
  input2 <- getLine
  let userSequence = input2
  checkSequence seq userSequence

execFuctionInTimeOrDie :: Int -> IO () -> IO ()
execFuctionInTimeOrDie time action = do
  result <- timeout time action
  case result of
    Nothing -> do
      putStrLn "Tempo esgotado!"
      return ()
    Just _ -> do
      return ()


initArrowsGame :: IO ()
initArrowsGame = do
  putStrLn "Bem Vindo ao Jogo das Setinhas"
  putStrLn " "
  putStrLn "Escolha sua fase:"
  putStrLn "1. Fácil"
  putStrLn "2. Médio"
  putStrLn "3. Difícil"

  input <- getLine
  let option = read input
  if option == 1 then do
    let timeoutEasySequence = 6000000
    let currentSequence = getSequenceEasy
    printCharacter currentSequence
    execFuctionInTimeOrDie timeoutEasySequence (getInput currentSequence)
    initArrowsGame

  else if option == 2 then do
    let timeoutMiddleSequence = 8000000
    let currentSequence = getSequenceMiddle
    printCharacter currentSequence
    execFuctionInTimeOrDie timeoutMiddleSequence (getInput currentSequence)
    initArrowsGame

  else if option == 3 then do
    let timeoutHardSequence = 10000000
    let currentSequence = getSequenceHard
    printCharacter currentSequence
    execFuctionInTimeOrDie timeoutHardSequence (getInput currentSequence)
    initArrowsGame

  else do
    putStr "option Invalida"
    printSpace
    initArrowsGame

