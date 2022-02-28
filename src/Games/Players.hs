module Players (
    Player,
    buildPlayer,
    createPlayers,
    getName,
    getIsPlaying,
    isNotPlaying,
    getId,
    setId,
    getPointing,
    setPointing
) where


import Distribution.Simple.PreProcess.Unlit (plain)


data Player = Player {
    identifier :: Int,
    name :: String,
    isPlaying :: Bool,
    pointing :: Int
}


buildPlayer :: Int -> String -> Int -> Player
buildPlayer id name = Player id name True


createPlayers :: Int -> Int -> [String] -> [Player]
-- createPlayers 0 position playersNames = []  -- Deve apresentar uma exceção
-- createPlayers numPlayers position [] = []   -- Deve apresentar uma exceção
createPlayers numPlayers position playerNames = do
    if position == numPlayers then
        [Player position (playerNames !! (position - 1)) True 0]
    else do
        Player position (playerNames !! (position - 1)) True 0 : createPlayers numPlayers (position + 1) playerNames


getName :: Player -> String 
getName = name


getIsPlaying :: Player -> Bool 
getIsPlaying = isPlaying


isNotPlaying :: Player -> Player
isNotPlaying player = Player (identifier player) (name player) False (pointing player)


getId :: Player -> Int 
getId = identifier


setId :: Player -> Int -> Player
setId player newId = Player newId (name player) (isPlaying player) (pointing player)


getPointing :: Player -> Int 
getPointing = pointing


setPointing :: Player -> Int -> Player
setPointing player addPoint = Player (identifier player) (name player) (isPlaying player) ((pointing player) + addPoint)