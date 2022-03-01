module Games.BlackJack (
    initBlackJackGame
) where

import Cards
import Game
import Util.Shurffle(Shuffle) -- usado para deixar a escolha das cartas aleatoria
import Data.String (String)

-- faz o loop do jogo
runGame :: Game -> IO ()
runGame currentState@
  (Game player@(Player playerHand) betoCarreiro@(Player betHand) cStatus deck)
  | cStatus == PlayerTurn = do
      putStrLn $ "Sua vez :"
      putStrLn $ "Você: " ++ show playerHand ++ " (" ++ show (score playerHand) ++ ")"
      putStrLn $ "Banca: " ++ show (head betHand) ++
        " (>" ++ show (score [head betHand]) ++ ")\n"
      playerMove <- continueOrStop
      runGame (playerTurn currentState playerMove) 
  | cStatus == CasinoTurn = do
      putStrLn "Round da Banca"
      putStrLn $ "Você: " ++ show playerHand ++ " (" ++ show (score playerHand) ++ ")"
      putStrLn $ "Banca: " ++ show betHand ++ " (" ++ show (score betHand) ++ ")\n"
      runGame (casinoTurn currentState)
  | cStatus == GameOver = do
      putStrLn $ "Fim de jogo; " ++  winner currentState
      putStrLn $ "Você: " ++ show playerHand ++ " (" ++ show (score playerHand) ++ ")"
      putStrLn $ "Banca: " ++ show betHand ++ " (" ++ show (score betHand) ++ ")\n"
      putStrLn $ "\n Vamos registar seu nome para salvar sua pontuação no ranking :) \n"
      playerName <- registerPlayer
      -- salva no banco playerName e score pHand
      playerChoice <- playAgain
      if (playerChoice == 1)
      then do initBlackJackGame
      else return ()
  | otherwise = return ()

registerPlayer:: IO String
registerPlayer =do
  putStrLn "Informe Seu nome: "
  name <- getLine
  return name

-- Pergunta se deseja puxar mais cartas ou parar
continueOrStop :: IO Int
continueOrStop = do
    putStrLn "Deseja continuar retirando cartas?"
    putStrLn "[1] Continuar"
    putStrLn "[2] Parar"
    option <- getLine
    let optionInt = read option :: Int
    return optionInt

-- Pergunta se deseja jogar novamente apos o fim
playAgain :: IO Int
playAgain = do
    putStrLn "Jogar Novamente?"
    putStrLn "[1] Sim"
    putStrLn "[2] Não"
    option <- getLine
    let optionInt = read option :: Int
    return optionInt

initBlackJackGame :: IO ()
initBlackJackGame = do
  putStrLn "\n Bem vindo a mesa de apostas do BlackJack!"
  randomCards <- shuffle deck
  let game = startGame randomCards
  runGame game 