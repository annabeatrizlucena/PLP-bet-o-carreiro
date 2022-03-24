module Util.General where

import qualified System.Process as SP

clearScreen :: IO ()
clearScreen = do
  _ <- SP.system "reset"
  return ()

printSpace :: IO ()
printSpace = do
  putStr "\n"
