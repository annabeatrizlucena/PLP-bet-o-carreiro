module Game
(
  Game(..),
  Player(..),
  GameStatus(..),
  startGame,
  playerTurn,
  casinoTurn,
  winner
) where

import Cards

data Player = Player Hand
  deriving (Show)
data GameStatus = PlayerTurn | CasinoTurn | GameOver | PlayerStayed
  deriving (Eq)

data Game = Game Player Player GameStatus Deck

startGame :: Deck -> Game
startGame deck@
  (p1:d1:p2:d2:tail) = Game (Player [p1, p2]) (Player [d1, d2]) PlayerTurn tail

winner :: Game -> [Char]
winner game@(Game player@(Player playerHand) casino@(Player casinoHand) gStatus _)
  | gStatus /= GameOver = error "Ainda não é possivel um vencendor."
  | isBust player || (score casinoHand > score casinoHand && not (isBust casino))
    = "A banca ganhou!"
  | score casinoHand == score playerHand || (blackjack casinoHand && blackjack playerHand) = "Empate."
  | blackjack casinoHand = "A banca ganhou!"
  | otherwise  = "Você ganhou!"
  
playerTurn :: Game -> Int -> Game
playerTurn game@(Game player@(Player hand) casino gStatus deck) playerMove
  | (playerMove == 1) = progressGame (hit game)
  | otherwise = progressGame (Game player casino PlayerStayed deck)

casinoTurn :: Game -> Game
casinoTurn game@(Game player@(Player playerHand) casino@(Player casinoHand) gStatus deck)
  | casinoHits game = progressGame (hit game)
  | otherwise = progressGame game

casinoHits :: Game -> Bool
casinoHits game@(Game player@(Player playerHand) cassino@(Player casinoHand) gStatus deck)
  = score casinoHand < 17 || (score casinoHand == 17 && containsAs casinoHand)

hit :: Game -> Game
hit game@
  (Game player@(Player playerHand) casino@(Player casinoHand) gStatus deck@(casinoHead:casinoTail))
  | gStatus == PlayerTurn =
    Game (Player (playerHand ++ [casinoHead])) casino gStatus casinoTail
  | gStatus == CasinoTurn =
    Game player (Player (casinoHand ++ [casinoHead])) gStatus casinoTail


progressGame :: Game -> Game
progressGame game@
  (Game player@(Player playerHand) casino@(Player casinoHand) gStatus deck@(casinoHead:casinoTail))

  | isBust player || (gStatus == CasinoTurn && not (casinoHits game))
    = Game player casino GameOver deck
  | gStatus == PlayerTurn = Game player casino PlayerTurn deck
  | gStatus == PlayerStayed || gStatus == CasinoTurn
    = Game player casino CasinoTurn deck
  | gStatus == CasinoTurn = Game player casino CasinoTurn deck

isBust :: Player -> Bool
isBust player@(Player hand) = score hand > 21
