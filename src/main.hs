{-# LANGUAGE GADTs #-}

import Games.Setas
import Games.SeteSeteSete
import Games.BlackJack
import GHC.Generics

printEspaco :: IO ()
printEspaco = do
  putStr "\n"

telaInicial :: IO ()
telaInicial = do
  printEspaco
  putStrLn "__________        __ /\\ ________    _________                                           "
  putStrLn "\\______   \\ _____/  |)/ \\_____  \\   \\_   ___ \\_____ ______________   ___________  ____  "
  putStrLn " |    |  _// __ \\   __\\  /   |   \\  /    \\  \\/\\__  \\\\_  __ \\_  __ \\_/ __ \\_  __ \\/  _ \\ "
  putStrLn " |    |   \\  ___/|  |   /    |    \\ \\     \\____/ __ \\|  | \\/|  | \\/\\  ___/|  | \\(  <_> )"
  putStrLn " |______  /\\___  >__|   \\_______  /  \\______  (____  /__|   |__|    \\___  >__|   \\____/ "
  putStrLn "        \\/     \\/               \\/          \\/     \\/                   \\/              "

  printEspaco
  putStr "          Casa de recreação que oferece jogos digitais operados por diversão"
  printEspaco

getMoeda :: IO ()
getMoeda = do       
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

    printEspaco

listOpcoesMenu :: IO ()
listOpcoesMenu = do
  putStr "Selecione a opção:\n"
  printEspaco
  putStr "1. Escolha seu jogo\n"
  putStr "2. Instruções\n"
  putStr "3. Ranking dos Jogadores\n"
  putStr "4. Créditos\n"
  putStr "5. Sair\n"


getCreditos :: IO()
getCreditos = do
  putStr "Projeto da disciplina Paradigmas da Linguagem de Programação, período 2021.1.\n"
  putStr "Desenvolvido por Anna Beatriz Lucena, Henrique Lemos, Mateus Ribeiro, Natália Salvino, Ricardo Sena."

getJogo :: Int -> IO()
getJogo jogo = do
  if jogo == 1 then iniciaJogoDasSetinhas
  else if jogo == 2 then startBlackJack
  else if jogo == 3 then start
  else putStr "Opção inválida"

getSaida :: IO()
getSaida = do
    putStrLn "Obrigada por perder dinheiro conosco, até a próxima! :)"
    printEspaco
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

getOpcoesMenu :: Int -> IO()
getOpcoesMenu opcao = do
  if opcao == 1 then getListaDeJogos
  else if opcao == 2 then getInstrucoes
  else if opcao == 3 then getInstrucoes
  else if opcao == 4 then getCreditos
  else if opcao == 5 then getSaida
  else getOpcoesMenu opcao

getInstrucoes :: IO()
getInstrucoes = do
    getInstrucoesJogoDasSetinhas
    -- setinhas
    -- blackjack
    -- 777 slots
    

getInstrucoesJogoDasSetinhas :: IO()
getInstrucoesJogoDasSetinhas = do
    putStr "1. Jogo das Setinhas\n"
    printEspaco
    putStr "Ao iniciar o jogo, uma sequência de caracteres (formada pelos caracteres awsd- que, no teclado, representam setas) irá aparecer na tela do usuário. Após isso, o usuário terá um tempo (determinado de acordo com a fase) para repetir a sequência.\n"
    printEspaco
    putStr "$ Para a fase fácil, a sequência será de 5 caracteres e o usuário terá 6 segundos para responder;\n"
    putStr "$ Para a fase médio, a sequência será de 7 caracteres e o usuário terá 8 segundos para responder;\n"
    putStr "$ Para a fase fácil, a sequência será de 10 caracteres e o usuário terá 10 segundos para responder.\n"

getInstrucoes777Slots :: IO()
getInstrucoes777Slots = do
    putStr "2. 777S lots\n"
    printEspaco
    putStr "Ao iniciar o jogo, uma sequência de 3 figuras aleatórias aparecerá na tela do usuário. "

getListaDeJogos :: IO()
getListaDeJogos = do
  putStr "No Bet' O Carrero temos os seguintes jogos:\n"
  printEspaco
  putStr "1. Jogo das setinhas\n"
  putStr "2. BlackJack\n"
  putStr "3. 777 slots\n"
  printEspaco
  putStr "Digite o número da opção que deseja:\n"
  input <- getLine
  let jogo = read input
  getJogo jogo

main :: IO()
main = do
    telaInicial
    printEspaco
    getMoeda
    listOpcoesMenu
    printEspaco
    input <- getLine
    let opcao = read input
    getOpcoesMenu opcao

