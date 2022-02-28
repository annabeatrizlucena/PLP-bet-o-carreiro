module Games.Setas (
    iniciaJogoDasSetinhas
) where
{-# LANGUAGE GADTs #-}

import Control.Concurrent
import Control.Monad (liftM)
import System.IO.Unsafe (unsafePerformIO)
import System.Random (Random (randomR), getStdRandom)
import System.Timeout
import qualified System.Process as SP

clearScreen :: IO ()
clearScreen = do
  _ <- SP.system "reset"
  return ()

printEspaco :: IO ()
printEspaco = do
  putStr "\n"

verificaSequencia :: String -> String -> IO()
verificaSequencia esperado resposta = do
  if esperado == resposta
    then print "RESPOSTA CORRETA! :)"
    else print "RESPOSTA INCORRETA :("
  


mostraElemento :: String -> IO ()
mostraElemento string = do
  if not (null string)
    then do
      print (head string)
      Control.Concurrent.threadDelay 1000000
      mostraElemento (drop 1 string)
    else do
      clearScreen
      
getSequenciaDaVezFacil :: String
getSequenciaDaVezFacil = do
  conn <- connectPostgreSQL "host='ec2-52-204-196-4.compute-1.amazonaws.com' port=5432 dbname='dchdcr7iap07pl' user='alxxpufsycowxx' password='ff89341db8b88bd30ae01f43290cbe396c7e3340fba82ebb52915b6a0f560998'"
  let numeroAleatorio = getNumeroAleatorio 1 15
  let sequencia = getPhase conn "facil" numeroAleatorio

getSequenciaDaVezMedio :: String
getSequenciaDaVezMedio = do
  conn <- connectPostgreSQL "host='ec2-52-204-196-4.compute-1.amazonaws.com' port=5432 dbname='dchdcr7iap07pl' user='alxxpufsycowxx' password='ff89341db8b88bd30ae01f43290cbe396c7e3340fba82ebb52915b6a0f560998'"
  let numeroAleatorio = getNumeroAleatorio 16 30
  let sequencia = getPhase conn "medio" numeroAleatorio

getSequenciaDaVezDificil :: String
getSequenciaDaVezDificil = do
  conn <- connectPostgreSQL "host='ec2-52-204-196-4.compute-1.amazonaws.com' port=5432 dbname='dchdcr7iap07pl' user='alxxpufsycowxx' password='ff89341db8b88bd30ae01f43290cbe396c7e3340fba82ebb52915b6a0f560998'"
  let numeroAleatorio = getNumeroAleatorio 31 45
  let sequencia = getPhase conn "dificil" numeroAleatorio

getNumeroAleatorio :: Int -> Int -> Int
{-# NOINLINE getNumeroAleatorio #-}
getNumeroAleatorio inicio fim = unsafePerformIO (getStdRandom (randomR (inicio, fim)))

getInput :: String -> IO ()
getInput seq = do
  input2 <- getLine
  let sequenciaUsuario = input2
  verificaSequencia seq sequenciaUsuario

execFuctionInTimeOrDie :: Int -> IO () -> IO ()
execFuctionInTimeOrDie time action = do
  result <- timeout time action
  case result of
    Nothing -> do
      putStrLn "Tempo esgotado!"
      return ()
    Just _ -> do
      return ()


iniciaJogoDasSetinhas :: IO ()
iniciaJogoDasSetinhas = do
  putStrLn "Bem Vindo ao Jogo das Setinhas"
  putStrLn " "
  putStrLn "Escolha sua fase:"
  putStrLn "1. Fácil"
  putStrLn "2. Médio"
  putStrLn "3. Difícil"

  input <- getLine
  let opcao = read input
  if opcao == 1 then do
    let timeoutSequenciaFacil = 6000000
    let sequenciaDaVez = getSequenciaDaVezFacil
    mostraElemento sequenciaDaVez
    execFuctionInTimeOrDie timeoutSequenciaFacil (getInput sequenciaDaVez)
    iniciaJogoDasSetinhas

  else if opcao == 2 then do
    let timeoutSequenciaMedio = 8000000
    let sequenciaDaVez = getSequenciaDaVezMedio
    mostraElemento sequenciaDaVez
    execFuctionInTimeOrDie timeoutSequenciaMedio (getInput sequenciaDaVez)
    iniciaJogoDasSetinhas

  else if opcao == 3 then do
    let timeoutSequenciaDificil = 10000000
    let sequenciaDaVez = getSequenciaDaVezDificil
    mostraElemento sequenciaDaVez
    execFuctionInTimeOrDie timeoutSequenciaDificil (getInput sequenciaDaVez)
    iniciaJogoDasSetinhas

  else do
    putStr "Opcao Invalida"
    printEspaco
    iniciaJogoDasSetinhas

