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

--listaJogos

main :: IO ()
main = do
  telaInicial
  printEspaco
  getMoeda
  getOpcoesMenu
