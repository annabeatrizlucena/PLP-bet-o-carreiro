module Util.Shuffle (shuffle) where

-- Algorithm from Haskell Docs: https://wiki.haskell.org/Random_shuffle

import Control.Monad (forM)
import Data.Array.IO
  ( IOArray,
    newListArray,
    readArray,
    writeArray,
  )
import System.Random (randomRIO)

-- | Randomly shuffle a list
--   /O(N)/
shuffle :: [a] -> IO [a]
shuffle xs = do
  ar <- newArray n xs
  forM [1 .. n] $ \i -> do
    j <- randomRIO (i, n)
    vi <- readArray ar i
    vj <- readArray ar j
    writeArray ar j vi
    return vj
  where
    n = length xs
    newArray :: Int -> [a] -> IO (IOArray Int a)
    newArray n xs = newListArray (1, n) xs