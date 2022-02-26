module Games.BlackJack (
    startBlackJack
) where


import System.IO.Unsafe ( unsafePerformIO )  
import System.Random ( Random(randomR), getStdRandom )
import Players
import Text.Printf (printf)
import Data.Time.Clock.POSIX (posixDayLength)
import Control.Monad.Except (replicateM)


showPointing :: String -> Int -> Int -> IO()
showPointing name card point = do
    printf (name ++ ", sua carta e: " ++ show card ++ "\n" ++ "Sua pontuação total e: " ++ show point)


continueGame :: Player -> IO() 
continueGame player = do
    printf ("Sua pontuacao: " ++ show (getPointing player) ++ "\n" ++ "Deseja continuar a jogar? [s/n]")
    read <$> getLine 


playing :: [Player] -> Int -> Int -> Bool -> [Player]
playing players numPlayers position start = do
    let player = players !! position
    let card = unsafePerformIO (getStdRandom (randomR (1, 13)))

    if position == numPlayers then do
        if start then do
            let point = getPointing player + card
            let update = setPointing player point
            -- showPointing (getName update) carta point
            [update]
        else do
            if getIsPlaying player then do
                answer <- ""  -- continueGame Player
                if answer == 's' then do
                    let point = getPointing player + card
                    let update = setPointing player point
                    -- showPointing (getName update) carta point
                    [update]
                else do
                    let update = isNotPlaying player
                    [update]
            else
                [player]
    else 
        if start then do
            let point = getPointing player + card
            let update = setPointing player point
            -- showPointing (getName update) carta point
            update : playing players numPlayers (position + 1) True 
        else do
            if getIsPlaying player then do
                answer <- ""  -- continueGame Player
                if answer == 's' then do
                    let point = getPointing player + card
                    let update = setPointing player point
                    -- showPointing (getName update) carta point
                    update : playing players numPlayers (position + 1) False 
                else do
                    let update = isNotPlaying player
                    update : playing players numPlayers (position + 1) False 
            else
                player : playing players numPlayers (position + 1) False


allStopped :: [Player] -> Int -> Int -> Int -> Bool 
allStopped players numPlayers posix numStopped = do
    let player = players !! posix

    if posix == numPlayers then
        numStopped == numPlayers 
    else do
        if getIsPlaying player then
            allStopped players numPlayers (posix + 1) (numStopped + 1)
        else
            allStopped players numPlayers (posix + 1) numStopped


checkHasWinner :: [Player] -> Int -> Int -> Bool 
checkHasWinner players numPlayers posix = do
    let player = players !! posix
    
    if getPointing player == 21 then
        True 
    else
        checkHasWinner players numPlayers (posix + 1)


getLoser :: [Player] -> Int -> String 
getLoser players numPlayers = do
    
    []


showScore :: [Player] -> Int -> String -> IO()
showScore players index nameLoser = do
    printf ""


-- blackjack :: [Player] -> String
-- blackjack players = do
--     play <- playing [players] numPlayers 1 True
--     let finished = allStopped play numPlayers 0 0
--     let hasWinner = checkHasWinner play numPlayers 0

--     if finished then
--         let loser = getLoser play numPlayers "allFinished"
--         -- showScore play 0 loser
--     else if hasWinner then
--         let loser = getLoser play numPlayers "hasWinner"
--         -- showScore play 0 loser
--     else
--         blackjack play


playBlackJack :: [String] -> Int -> String 
playBlackJack namePlayers numPlayers = do
    players <- createPlayers numPlayers 0 namePlayers

    if numPlayers == 2 then do
        -- executar o blackjack para jogar
        -- Imprimir o retorno do blackjack informando o ganhador do jogo
        -- 
        -- 
        []  -- realizar uma continuação até que se tenha todos os jogadores finalizados 
            -- ou pelo menos um deles com 21
    else 
        []
        -- executa o blackjack para jogar
        -- executa o removeLoser para retirar a pessoa com maior quantidade de pontos
        -- imprimir o retorno do ganhador da rodada e quem saiu do jogo
        -- executar o playBlackJack novamente, sem o jogador perdedor

startBlackJack :: IO()
startBlackJack = do
    printf "Quantos jogadores irao participar? (Mínimo 2)"
    numeroJogadores <- getLine
    let numJogadores = read numeroJogadores

    printf "Insira o nome do(s) Jogador(es):"
    listaJogadores <- replicateM numJogadores getLine
    print (playBlackJack listaJogadores numJogadores)
    print "aaaa"
-- Fazer o getLoser
-- Ajeitar para aparecer os prints
-- Fazer o showScore
-- Terminar o playBlackJack
