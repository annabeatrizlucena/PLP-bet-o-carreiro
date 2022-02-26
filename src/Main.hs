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

main :: IO()
main = do
    telaInicial
    printEspaco
    getMoeda
    getOpcoesMenu
    printEspaco
    getInstrucoes