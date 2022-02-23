module BlackJack (
    playBlackJack
) where

import System.IO.Unsafe ( unsafePerformIO )  
import System.Random ( Random(randomR), getStdRandom )
import Players


playing :: [Player] -> Int -> Int -> Bool -> [Player]
playing players numPlayers position start = do
    let player = players !! position
    let card = unsafePerformIO (getStdRandom (randomR (1, 13)))

    if position == numPlayers then do
        if start then do
            let point = getPointing player + card
            let update = setPointing player point
            -- showPonting (getName update) carta point
            [update]
        else do
            if getIsPlaying player then do
                answer <- ""  -- continueGame Player
                if answer == 's' then do
                    let point = getPointing player + card
                    let update = setPointing player point
                    -- showPonting (getName update) carta point
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
            -- showPonting (getName update) carta point
            update : playing players numPlayers (position + 1) True 
        else do
            if getIsPlaying player then do
                answer <- ""  -- continueGame Player
                if answer == 's' then do
                    let point = getPointing player + card
                    let update = setPointing player point
                    -- showPonting (getName update) carta point
                    update : playing players numPlayers (position + 1) False 
                else do
                    let update = isNotPlaying player
                    update : playing players numPlayers (position + 1) False 
            else
                player : playing players numPlayers (position + 1) False


playBlackJack :: [String] -> Int -> String 
playBlackJack namePlayers numPlayers = do
    players <- createPlayers numPlayers 1 namePlayers

    if numPlayers == 2 then do
        play <- playing [players] numPlayers 1 True
        []  -- realizar uma continuação até que se tenha todos os jogadores finalizados 
            -- ou pelo menos um deles com 21
    else 
        []

--     -- pontos <- iniciaPartida jogadores numJogadores
--     -- continuaPontos <- continuaJogo jogadores numJogadores pontos

    -- if numJogadores == 2 then
    --     []
    -- else
    --     []
--         -- finalizaPartida jogadores
--         -- iniciaPartida continuaJogo jogadores (numJogadores - 1)