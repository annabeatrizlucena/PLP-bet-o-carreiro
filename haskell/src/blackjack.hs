import System.IO.Unsafe ( unsafePerformIO )                                         
import System.Random ( Random(randomR), getStdRandom )
import Control.Monad.Except (replicateM)
import Text.Printf (printf)
import Data.Binary (Binary(putList))
import Text.Read (Lexeme(String))

-- acumuladoJogador:: String -> Int -> Int
-- acumuladoJogador jogador pontuacao 

-- puxaCarta:: String -> Int 
-- puxaCarta jogador=
--     

-- entregaCartas:: [String] ->[Int] -> [Int] 
-- entregaCartas (jogador:[]) (ponto:[]) continuaJogo jogadores pontos
-- entregaCartas (jogador:jogadores) (ponto:pontos) = [ponto + puxaCarta jogador] ++ entregaCartas jogadores pontos

entregaCartas:: [String] -> Int -> Int -> [Int] -> String 
entregaCartas jogadores numJogadores posicao pontos = do
    let jogador = jogadores !! posicao
    let carta = 11          -- Definir o valor da carta para o jogador

    if posicao == 0 
        then do
            let novaPontuacao = pontos !! posicao + carta : drop 1 pontos
            jogador ++ " esta é sua carta: " ++ show carta ++ "\n" ++ "Pontuacao total: " ++ show novaPontuacao ++ "\n"
    else 
        if posicao == (numJogadores - 1) 
            then do
                let novaPontuacao = take (posicao + 1) pontos ++ [(pontos !! posicao) + carta]
                jogador ++ " esta é sua carta: " ++ show carta ++ "\n" ++ "Pontuacao total: " ++ show novaPontuacao ++ "\n"
            else do
                comeco <- take posicao pontos
                alterado <- [(pontos !! posicao) + carta]
                fim <- [drop (posicao + 1) pontos]
                let novaPontuacao = comeco : alterado : fim
                jogador ++ " esta é sua carta: " ++ show carta ++ "\n" ++ "Pontuacao total: " ++ show comeco ++ "\n"
    -- jogador ++ " esta é sua carta: " ++ show carta ++ "\n" ++ "Pontuacao total: " ++ show novaPontuacao ++ "\n"





    
    


iniciaPartida:: [String] -> Int -> String 
iniciaPartida jogadores numJogadores = do
    let pontos = replicate  numJogadores 0
    entregaCartas jogadores numJogadores 0 pontos

--iniciaJogo (x:[]) = [x] --Ja retorna o vencedor caso so tenha um jogador
-- posição = 0
-- pontos = []
--iniciaJogo jogadores=
--    let pontos = [0,0,0]

-- continuaJogo:: [String] -> [Int] -> [Int]
-- continuaJogo jogadores pontos =
--     pontos

jogarBlackJack:: [String] -> Int -> String
jogarBlackJack jogadores numJogadores = do
    iniciaPartida jogadores numJogadores
    -- printf "Teste"
    -- print entregaCartas
    -- 
    -- 
    -- iniciaPartida [jogadores] -> [pontos]           //Apresenta a primeira carta, com seu respectivo valor, para o(s) usuário(s)
    -- continuaJogo [jogadores] -> [pontos]         //Realiza as mesmas coisas do iniciaJogo mas verificará se o jogador deseja parar ou receber outra carta
    -- if jogadores == 2
    --    finalizaJogo                              //Retorna o vencedor
    -- else:
    --    finalizaPartida                           //Remove o jogador perdedor
    --    iniciaJogo [jogadores] -> [pontos]


main:: IO()
main = do
    print "Quantos jogadores irao participar? (minimo 2, maximo 3)"
    inputNumeroJogadores <- getLine
    let numJogadores = read inputNumeroJogadores
    
    print "Insira o nome do(s) jogador(es):"
    listaJogadores <- replicateM numJogadores getLine 
    
    printf (jogarBlackJack listaJogadores numJogadores)