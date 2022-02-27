module Games.Setas (
    iniciaJogoDasSetinhas
) where
{-# LANGUAGE GADTs #-}

import Control.Concurrent
import Control.Monad (liftM)
import System.IO.Unsafe (unsafePerformIO)
import System.Random (Random (randomR), getStdRandom)
import System.Timeout

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
      putStrLn ".\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\nInsira a sequência Correta:"

getSequenciaDaVezFacil :: String
getSequenciaDaVezFacil = do
  let numeroAleatorio = getNumeroAleatorio
  let listaFacil = ["aaswd", "aaswd", "wdsaw", "swdaa", "dwsdd", "wswaa", "dsaws", "sswda", "sdaws", "ddasw", "awsdw", "sadws", "dawsw", "sawds", "awdsa", "wasda"]
  listaFacil !! numeroAleatorio

getSequenciaDaVezMedio :: String
getSequenciaDaVezMedio = do
  let numeroAleatorio = getNumeroAleatorio
  let listaMedio = ["wdsaawdswasdwad", "awdswsdawasdaws", "wsadwsdwsdwsdaw", "awsdwsdawdsawsa", "awaaawsdswwdads", "dsadwswswadswsa", "swdsadwswswsads", "dswaswddswsawsd", "wsaswswsdwawsws", "awswwwdddsssawd", "dawdwsdwswdwsda", "wsdawswsswswdwd", "awaawwdwdwadaas", "ssadwswasswsswa", "asdwswaswsasass"]
  listaMedio !! numeroAleatorio

getSequenciaDaVezDificil :: String
getSequenciaDaVezDificil = do
  let numeroAleatorio = getNumeroAleatorio
  let listaDificil = ["asswswsdsadssdawssaw", "sdwasdwsaswsdwdsadsw", "wswsswddsawsdswsaswd", "daswswsdsawaswdwswwa", "sdaswsawsdwdswswsdwd", "swddswssawddswdswdsa", "dwsawsawdswsddadawws", "sasdaswsswsadwwsdsad", "daddwsaswsawdwsadsad", "sawdswswsdsawdsswssw", "wasdwsswdswssaswdswa", "wswsdwswswssasasassa", "asddsaswasswsswsddwd", "dsdsswasdswdswsdwdsw", "sawsdwsasddswdswsaws"]
  listaDificil !! numeroAleatorio

getNumeroAleatorio :: Int
{-# NOINLINE getNumeroAleatorio #-}
getNumeroAleatorio = unsafePerformIO (getStdRandom (randomR (0, 14)))

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

