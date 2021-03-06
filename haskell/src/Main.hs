{-# LANGUAGE GADTs #-}

import DatabasePostgre.DataPost
import GHC.Generics
import Games.BlackJack
import Games.Setas
import Games.SeteSeteSete
import Util.General

homeScreen :: IO ()
homeScreen = do
  printSpace
  putStrLn "__________        __ /\\ ________    _________                                           "
  putStrLn "\\______   \\ _____/  |)/ \\_____  \\   \\_   ___ \\_____ ______________   ___________  ____  "
  putStrLn " |    |  _// __ \\   __\\  /   |   \\  /    \\  \\/\\__  \\\\_  __ \\_  __ \\_/ __ \\_  __ \\/  _ \\ "
  putStrLn " |    |   \\  ___/|  |   /    |    \\ \\     \\____/ __ \\|  | \\/|  | \\/\\  ___/|  | \\(  <_> )"
  putStrLn " |______  /\\___  >__|   \\_______  /  \\______  (____  /__|   |__|    \\___  >__|   \\____/ "
  putStrLn "        \\/     \\/               \\/          \\/     \\/                   \\/              "

  printSpace
  putStr "          Casa de recreação que oferece jogos digitais operados por diversão"
  printSpace

getBetCoin :: IO ()
getBetCoin = do
  putStrLn "                                    ██████████"
  putStrLn "                                  ██░░░░░░░░░░██"
  putStrLn "                                ██░░░░██░░██░░░░██"
  putStrLn "                              ██░░░░████████░░░░░░██"
  putStrLn "                              ██░░░░██░░░░░░██░░░░██"
  putStrLn "                              ██░░░░████████░░░░░░██"
  putStrLn "                              ██░░░░██░░░░░░██░░░░██"
  putStrLn "                              ██░░░░████████░░░░░░██"
  putStrLn "                                ██░░░░██░░██░░░░██"
  putStrLn "                                  ██░░░░░░░░░░██"
  putStrLn "                                    ██████████"

  printSpace

listMenuOptions :: IO ()
listMenuOptions = do
  putStr "Selecione a Opção:\n"
  printSpace
  putStr "[1] Escolha seu Jogo\n"
  putStr "[2] Instruções\n"
  putStr "[3] Ranking dos Jogadores\n"
  putStr "[4] Créditos\n"
  putStr "[5] Sair\n"

getCredits :: IO ()
getCredits = do
  putStr "Projeto da disciplina Paradigmas da Linguagem de Programação, período 2021.1.\n"
  putStr "Desenvolvido por Anna Beatriz Lucena, Henrique Lemos, Mateus Ribeiro, Natália Salvino, Ricardo Sena.\n"

getGame :: Int -> IO ()
getGame jogo = do
  if jogo == 1
    then initArrowsGame
    else
      if jogo == 2
        then initBlackJackGame 0
        else
          if jogo == 3
            then start
            else putStr "Opção inválida"

exit :: IO ()
exit = do
  putStrLn "Obrigada por perder dinheiro conosco, até a próxima! 😜"
  printSpace
  putStrLn "                                             ▓▓▓▓                      "
  putStrLn "                                            ▓▓    ▓▓▓▓                "
  putStrLn "                                          ▓▓  ░░░░    ▓▓▓▓            "
  putStrLn "                                        ▓▓  ░░▒▒▒▒▒▒▒▒    ▓▓▓▓        "
  putStrLn "                                    ▓▓▓▓  ░░░░▒▒░░░░▒▒▒▒▒▒    ▓▓▓▓    "
  putStrLn "                                ▒▒▒▒░░░░▒▒▒▒░░▒▒▒▒▒▒░░░░▒▒░░░░    ▓▓▓▓"
  putStrLn "                            ▒▒▒▒░░░░░░░░░░░░▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░  ▓▓▓▓  "
  putStrLn "                        ▓▓▓▓░░░░░░░░░░░░░░░░░░░░▓▓▒▒▒▒░░░░░░  ▓▓▓▓▓▓  "
  putStrLn "                  ▓▓▓▓▓▓░░░░▓▓▓▓░░░░░░░░░░░░░░░░    ▒▒▒▒░░  ▓▓▓▓▓▓▓▓  "
  putStrLn "            ▓▓▓▓▓▓  ░░░░▒▒▒▒▓▓▒▒▒▒▓▓░░░░░░░░          ░░▓▓▓▓▓▓▓▓▓▓▓▓  "
  putStrLn "        ▓▓▓▓      ░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒        ▒▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓"
  putStrLn "        ▓▓▒▒▓▓▓▓    ░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒    ▒▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓  "
  putStrLn "      ▒▒▒▒▓▓▒▒▒▒▓▓▓▓    ░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓    "
  putStrLn "    ▒▒    ▓▓▒▒▒▒▒▒▒▒▓▓▓▓    ░░░░    ░░▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓          "
  putStrLn "  ▒▒  ░░░░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓    ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒            ▒▒          "
  putStrLn "▒▒░░░░░░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓██████▓▓▓▓██▒▒▒▒▒▒      ▒▒▒▒▒▒▒▒▒▒        "
  putStrLn "▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒████████████████▒▒▒▒▒▒                ▒▒      "
  putStrLn "▒▒▒▒        ▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒████████████▓▓▓▓▒▒▒▒▒▒            ▒▒▒▒▒▒▒▒▒▒  "
  putStrLn "                ▓▓▓▓▒▒▒▒▒▒▒▒████████████████      ▒▒                ░░░░▒▒"
  putStrLn "                    ▓▓▓▓▒▒▒▒████████████          ▒▒            ▒▒▒▒▒▒▒▒▒▒"
  putStrLn "                        ▓▓▓▓████████              ▒▒          ░░░░░░░░░░▒▒"
  putStrLn "                            ████                    ▒▒    ░░░░░░▒▒▒▒▒▒▒▒▒▒"
  putStrLn "                                                      ▒▒░░░░░░░░░░░░░░░░▒▒"
  putStrLn "                                                        ▒▒░░░░░░░░▒▒▒▒▒▒▒▒"
  putStrLn "                                                          ▒▒░░░░░░░░▒▒▒▒  "
  putStrLn "                                                          ▒▒░░░░░░▒▒░░░░▒▒"
  putStrLn "                                                            ▒▒░░░░░░▒▒▒▒▒▒"
  putStrLn "                                                            ▒▒░░▒▒░░░░▒▒  "
  putStrLn "                                                            ▒▒░░░░▒▒▒▒▒▒  "
  putStrLn "                                                              ▒▒░░▒▒      "
  putStrLn "                                                              ▒▒░░▒▒      "
  putStrLn "                                                                ▒▒        "

getMenuOptions :: Int -> IO ()
getMenuOptions opcao = do
  if opcao == 1
    then getGameList
    else
      if opcao == 2
        then getInstructions
        else
          if opcao == 3
            then listagemRank
            else
              if opcao == 4
                then getCredits
                else
                  if opcao == 5
                    then exit
                    else getMenuOptions opcao

getInstructions :: IO ()
getInstructions = do
  printSpace
  getInstructionsArrowsGame
  printSpace
  getInstructions777Slots
  printSpace
  getInstructionsBlackJack
  printSpace

getInstructionsArrowsGame :: IO ()
getInstructionsArrowsGame = do
  putStr "1. Jogo das Setinhas\n"
  printSpace
  putStr "Ao iniciar o jogo, uma sequência de caracteres (formada pelos caracteres awsd- que, no teclado, representam setas) irá aparecer na tela do usuário. Após isso, o usuário terá um tempo (determinado de acordo com a fase) para repetir a sequência.\n"
  printSpace
  putStr "$ Para a fase fácil, a sequência será de 5 caracteres e o usuário terá 6 segundos para responder;\n"
  putStr "$ Para a fase médio, a sequência será de 7 caracteres e o usuário terá 8 segundos para responder;\n"
  putStr "$ Para a fase fácil, a sequência será de 10 caracteres e o usuário terá 10 segundos para responder.\n"

getInstructions777Slots :: IO ()
getInstructions777Slots = do
  putStr "2. 777 Slots\n"
  printSpace
  putStrLn "Ao iniciar o jogo, uma sequência de 3 figuras aleatórias aparecerá na tela do usuário. Cada sequência tem um valor pré-estabelecido. "

getInstructionsBlackJack :: IO ()
getInstructionsBlackJack = do
  putStr "3. BlackJack\n"
  printSpace
  putStr "O objetivo de qualquer mão de Blackjack é derrotar o dealer. Para fazer isso, você deve ter uma mão em que a pontuação seja mais elevada do que a mão do dealer, mas não exceda 21 no valor total. Como alternativa, você pode ganhar tendo uma pontuação menor que 22 quando o valor da mão do dealer ultrapassar 21."

getGameList :: IO ()
getGameList = do
  putStr "No Bet' O Carrero temos os seguintes jogos:\n"
  printSpace
  putStr "[1] Jogo das setinhas\n"
  putStr "[2] BlackJack\n"
  putStr "[3] 777 slots\n"
  printSpace
  putStr "Digite o número da opção que deseja:\n"
  input <- getLine
  let game = read input
  clearScreen
  getGame game

formatUserScore :: User -> String
formatUserScore (User nome pontuacao) = nome ++ "\t\t    " ++ show pontuacao

listagemRank :: IO ()
listagemRank = do
  putStrLn "   Listagem de Rank"
  putStrLn "   -------\\o/-------"
  printSpace
  putStrLn "Nome\t\tPontuação"
  putStrLn "-------------------------"
  conn <- conectToPostDatabase
  top5 <- getUsersFiveHighestScores conn
  mapM_ (putStrLn . formatUserScore) top5

main :: IO ()
main = do
  clearScreen
  homeScreen
  printSpace
  getBetCoin
  listMenuOptions
  printSpace
  input <- getLine
  let opcao = read input
  clearScreen
  getMenuOptions opcao
