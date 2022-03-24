module Games.Cards
  ( Card (..),
    Deck,
    Hand (..),
    score,
    deck,
    containsAs,
    blackjack,
  )
where

data Card
  = As
  | Dois
  | Tres
  | Quatro
  | Cinco
  | Seis
  | Sete
  | Oito
  | Nove
  | Dez
  | Joker
  | Rainha
  | Rei
  deriving (Eq, Show)

type Deck = [Card]

type Hand = [Card]

suit :: [Card]
suit =
  [ Dois,
    Tres,
    Quatro,
    Cinco,
    Seis,
    Sete,
    Oito,
    Nove,
    Dez,
    Joker,
    Rainha,
    Rei,
    As
  ]

deck :: Deck
deck = foldl (\acc x -> acc ++ suit) [] [1 .. 4]

-- mapea o valor para cada carta
value :: Card -> Int
value Dois = 2
value Tres = 3
value Quatro = 4
value Cinco = 5
value Seis = 6
value Sete = 7
value Oito = 8
value Nove = 9
value Dez = 10
value Joker = 10
value Rainha = 10
value Rei = 10
value As = 11

score :: Hand -> Int
score [] = 0
score (h : hd) = value h + score hd

containsAs :: Hand -> Bool
containsAs [] = False
containsAs (head : tail)
  | head == As = True
  | otherwise = containsAs tail

blackjack :: Hand -> Bool
blackjack h
  | score h == 21 && length h == 2 = True
  | otherwise = False