module Games.BlackJack
  ( initBlackJackGame,
  )
where

-- usado para deixar a escolha das cartas aleatoria
import Data.String (String)
import Database.PostgreSQL.Simple.FromField (name)
import DatabasePostgre.DataPost
  ( conectToPostDatabase,
    insertUsernameAndUserScore,
  )
import Games.Cards
import Games.Game
import Util.Shuffle

keepScore :: Int -> Int -> Int
keepScore score playerScore = score + playerScore

-- faz o loop do jogo
runGame :: Game -> Int -> IO ()
runGame
  currentState@(Game player@(Player playerHand) betoCarreiro@(Player betHand) cStatus deck)
  winScore
    | cStatus == PlayerTurn = do
      putStrLn $ "Sua vez :"
      putStrLn $ "Você: " ++ show playerHand ++ " (" ++ show (score playerHand) ++ ")"
      putStrLn $
        "Banca: " ++ show (head betHand)
          ++ " (>"
          ++ show (score [head betHand])
          ++ ")\n"
      playerMove <- continueOrStop
      runGame (playerTurn currentState playerMove) winScore
    | cStatus == CasinoTurn = do
      putStrLn "Round da Banca"
      putStrLn $ "Você: " ++ show playerHand ++ " (" ++ show (score playerHand) ++ ")"
      putStrLn $ "Banca: " ++ show betHand ++ " (" ++ show (score betHand) ++ ")\n"
      runGame (casinoTurn currentState) winScore
    | cStatus == GameOver = do
      putStrLn $ "Fim de jogo; " ++ winner currentState
      putStrLn $ "Você: " ++ show playerHand ++ " (" ++ show (score playerHand) ++ ")"
      putStrLn $ "Banca: " ++ show betHand ++ " (" ++ show (score betHand) ++ ")\n"
      let actualWinScore = getActualWinScore currentState winScore
      playerChoice <- playAgain actualWinScore
      if playerChoice == 1
        then do
          initBlackJackGame actualWinScore
        else do
          putStrLn "\n Vamos registar seu nome para salvar suas betcoins no ranking 😊 \n"
          putStrLn "Digite seu nome: "
          playerName <- getLine
          conn <- conectToPostDatabase
          insertUsernameAndUserScore conn playerName actualWinScore
          return ()
    | otherwise = return ()

getActualWinScore :: Game -> Int -> Int
getActualWinScore game score = do
  if checkPlayerWin game then score + 10 else score - 12

checkPlayerWin :: Game -> Bool
checkPlayerWin (Game player@(Player playerHand) betoCarreiro@(Player betHand) cStatus deck)
  | score playerHand > 21 = False
  | score playerHand == 21 = True
  | score betHand > 21 = True
  | score playerHand > score betHand = True
  | otherwise = False

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
playAgain :: Int -> IO Int
playAgain score = do
  putStrLn $ "Jogar Novamente? Você possui " ++ show score ++ " betcoins"
  putStrLn "[1] Sim"
  putStrLn "[2] Não"
  option <- getLine
  let optionInt = read option :: Int
  return optionInt

initBlackJackGame :: Int -> IO ()
initBlackJackGame winScore = do
  putStrLn "\n Bem vindo a mesa de apostas do BlackJack!"
  randomCards <- shuffle deck
  let game = startGame randomCards
  runGame game winScore