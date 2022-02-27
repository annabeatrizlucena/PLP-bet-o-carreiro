module BlackJack (
    playBlackJack
) where


import System.IO.Unsafe ( unsafePerformIO )  
import System.Random ( Random(randomR), getStdRandom )
import Players
import Text.Printf (printf)


showPointing :: String -> Int -> Int -> IO()
showPointing name card point = do
    printf (name ++ ", sua carta e: " ++ show card ++ "\n" ++ "Sua pontuação total e: " ++ show point)


continueGame :: Player -> IO() 
continueGame player = do
    printf ("Sua pontuacao: " ++ show (getPointing player) ++ "\n" ++ "Deseja continuar a jogar? [s/n]")
    read <$> getLine 


playing :: [Player] -> Int -> Int -> Bool -> Either [Player] IO()
playing players numPlayers position start = do
    let player = players !! position
    let card = unsafePerformIO (getStdRandom (randomR (1, 13)))

    if position == numPlayers then do
        if start then do
            let point = getPointing player + card
            let update = setPointing player point
            
            showPointing (getName update) carta point
            [update]
        else do
            if getIsPlaying player then do
                answer <- continueGame Player
                if answer == 's' then do
                    let point = getPointing player + card
                    let update = setPointing player point
                    
                    showPointing (getName update) carta point
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
            
            showPointing (getName update) carta point
            update : playing players numPlayers (position + 1) True 
        else do
            if getIsPlaying player then do
                answer <- continueGame Player
                if answer == 's' then do
                    let point = getPointing player + card
                    let update = setPointing player point
                    showPointing (getName update) carta point
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
getLoser players numPlayers posix lowPoint loser = do
    if posix == numPlayers then 
        loser
    else do
        player <- players !! posix
        point <- getPointing player

        if posix == 0 || point < lowPoint then do
            let newLowPoint = point
            let nameLoser = getName player
            getLoser players numPlayers (posix + 1) newLowPoint nameLoser
        else
            getLoser players numPlayers (posix + 1) lowPoint loser


showScore :: [Player] -> Int -> String -> IO()
showScore players index nameLoser posix = do
    printf ""
-- Apresentar um placar com a pontuação dos jogadores e o nome do que perdeu


removeLoser :: [Player] -> Int -> String -> Int -> [String] -> [String]
removeLoser players numPlayers loser posix newList = do
    if posix == numPlayers then newList
    else do
        playerName <- getName (players !! posix)
        
        if playerName == loser then
            removeLoser players numPlayers loser (posix + 1) newList
        else do
            notLosers <- newList : playerName
            removeLoser players numPlayers loser (posix + 1) notLosers


blackjack :: [Player] -> Either String IO()
blackjack players = do
    play <- playing [players] numPlayers 1 True
    
    let finished = allStopped play numPlayers 0 0
    let hasWinner = checkHasWinner play numPlayers 0

    if finished || hasWinner then do
        let loser = getLoser play numPlayers
        showScore play 0 loser
        loser
    else
        blackjack play


endGame :: IO()
endGame = do
    printf ""
-- Exibir um fim de jogo bem legal


playBlackJack :: [String] -> Int -> Either String IO() 
playBlackJack namePlayers numPlayers = do
    players <- createPlayers numPlayers 0 namePlayers

    if numPlayers == 2 then
        blackjack players numPlayers
        endGame
    else do
        loser <- blackjack players numPlayers
        newListNames <- removeLoser players numPlayers loser 0 []
        playBlackJack newListName (numPlayers - 1)