printEspaco :: IO()
printEspaco = do
    putStr "\n"

telaInicial :: IO()
telaInicial = do
    printEspaco
    putStr "--------------------------BET' O Carrero--------------------------\n"
    printEspaco
    putStr "Casa de recreação que oferece jogos digitais operados por diversão"
    printEspaco

getMoeda :: IO()
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
    


getOpcoesMenu :: IO()
getOpcoesMenu = do
    putStr "Selecione a opção:\n"
    printEspaco
    putStr "1. Listagem de Jogos\n"
    putStr "2. Instruções\n"
    putStr "3. Ranking dos Jogadores\n"
    putStr "4. Créditos\n"
    putStr "5. Sair\n"

--listaJogos

main :: IO()
main = do
    telaInicial
    printEspaco
    getMoeda
    getOpcoesMenu
