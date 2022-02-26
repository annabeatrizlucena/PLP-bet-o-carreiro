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
  putStr "Casa de recreação que oferece jogos digitais operados por diversão"
  printEspaco

getMoeda :: IO ()
getMoeda = do
  putStr "                      $$$$$$$$$$$$$$$$$$\n"
  putStr "                     $$$$$$$$$$$$$$$$$$$$\n"
  putStr "                   $$$$   ==||=||==    $$$$\n"
  putStr "                   $$$$  || || ||      $$$$\n"
  putStr "                   $$$$  || || ||      $$$$\n"
  putStr "                   $$$$  || || ||      $$$$\n"
  putStr "                   $$$$   ==||======   $$$$\n"
  putStr "                   $$$$     || ||  ||  $$$$\n"
  putStr "                   $$$$     || ||  ||  $$$$\n"
  putStr "                   $$$$     || ||  ||  $$$$\n"
  putStr "                   $$$$  ===||=||===   $$$$\n"
  putStr "                     $$$$$$$$$$$$$$$$$$$$\n"
  putStr "                      $$$$$$$$$$$$$$$$$$\n"
  printEspaco

getOpcoesMenu :: IO ()
getOpcoesMenu = do
  putStr "Selecione a opção:\n"
  printEspaco
  putStr "1. Listagem de Jogos\n"
  putStr "2. Instruções\n"
  putStr "3. Ranking dos Jogadores\n"
  putStr "4. Créditos\n"
  putStr "5. Sair\n"


getCreditos :: IO()
getCreditos = do
  putStr "Projeto da disciplina Paradigmas da Linguagem de Programação, período 2021.1.\n"
  putStr "Desenvolvido por Anna Beatriz Lucena, Henrique Lemos, Mateus Ribeiro, Natália Salvino, Ricardo Sena."

getJogo :: Int -> String
getJogo jogo = do
  if jogo == 1 then "jogo1"
  else if jogo == 2 then "jogo2"
  else if jogo == 3 then "jogo3"
  else "Opção inválida"


getListaDeJogos :: IO()
getListaDeJogos = do
  putStr "No Bet' O Carrero temos os seguintes jogos:\n\n1.Jogo das setinhas\n2.BlackJack\n3.777 slots"
  putStr "Digite o número da opção que deseja:"
  input <- getLine
  let jogo = read input
  print(getJogo jogo)
  

main :: IO ()
main = do
  telaInicial
  printEspaco
  getMoeda
  getOpcoesMenu

