import Control.Concurrent
import System.Random (Random(randomRIO))


verificaSequencia :: String -> String -> String 
verificaSequencia esperado resposta = do
    if(esperado == resposta) then "RESPOSTA CORRETA! :)"
    else "RESPOSTA INCORRETA :("


mostraElemento :: String -> IO()
mostraElemento string =  do
    if (length string > 0) then do
        print (head string)
        Control.Concurrent.threadDelay 2000000
        mostraElemento (drop 1 string)
    else do 
        putStrLn ".\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\nInsira a sequência Correta:"

getSequenciaDaVez :: String 
getSequenciaDaVez = do
    let numeroAleatorio = randomRIO (1,10 :: Int)
    let listaFacil = ["aaswd","aaswd","wdsaw","swdaa","dwsdd","wswaa","dsaws","sswda","sdaws","ddasw","awsdw","sadws","dawsw","sawds","awdsa","wasda"]
    let listaMedio = ["wdsaawdswasdwad","awdswsdawasdaws","wsadwsdwsdwsdaw","awsdwsdawdsawsa","awaaawsdswwdads","dsadwswswadswsa","swdsadwswswsads","dswaswddswsawsd","wsaswswsdwawsws","awswwwdddsssawd","dawdwsdwswdwsda","wsdawswsswswdwd","awaawwdwdwadaas","ssadwswasswsswa","asdwswaswsasass"]
    let listaDificil = ["asswswsdsadssdawssaw","sdwasdwsaswsdwdsadsw","wswsswddsawsdswsaswd","daswswsdsawaswdwswwa","sdaswsawsdwdswswsdwd","swddswssawddswdswdsa","dwsawsawdswsddadawws","sasdaswsswsadwwsdsad","daddwsaswsawdwsadsad","sawdswswsdsawdsswssw","wasdwsswdswssaswdswa","wswsdwswswssasasassa","asddsaswasswsswsddwd","dsdsswasdswdswsdwdsw","sawsdwsasddswdswsaws"]
    listaFacil!!5


main :: IO ()
main = do
    let sequenciaDaVez = getSequenciaDaVez
    mostraElemento sequenciaDaVez
    input2 <- getLine
    let sequenciaUsuario = input2
    print (verificaSequencia sequenciaDaVez sequenciaUsuario)
