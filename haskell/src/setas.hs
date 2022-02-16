import Control.Concurrent
import System.IO.Unsafe ( unsafePerformIO )                                         
import System.Random ( Random(randomR), getStdRandom )
import System.Timeout
import Control.Monad (liftM)


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

getSequenciaDaVezFacil :: String 
getSequenciaDaVezFacil = do
    let numeroAleatorio = getNumeroAleatorio
    let listaFacil = ["aaswd","aaswd","wdsaw","swdaa","dwsdd","wswaa","dsaws","sswda","sdaws","ddasw","awsdw","sadws","dawsw","sawds","awdsa","wasda"]
    listaFacil!!numeroAleatorio

getSequenciaDaVezMedio :: String 
getSequenciaDaVezMedio = do
    let numeroAleatorio = getNumeroAleatorio
    let listaMedio = ["wdsaawdswasdwad","awdswsdawasdaws","wsadwsdwsdwsdaw","awsdwsdawdsawsa","awaaawsdswwdads","dsadwswswadswsa","swdsadwswswsads","dswaswddswsawsd","wsaswswsdwawsws","awswwwdddsssawd","dawdwsdwswdwsda","wsdawswsswswdwd","awaawwdwdwadaas","ssadwswasswsswa","asdwswaswsasass"]
    listaMedio!!numeroAleatorio

getSequenciaDaVezDificil :: String 
getSequenciaDaVezDificil = do
    let numeroAleatorio = getNumeroAleatorio
    let listaDificil = ["asswswsdsadssdawssaw","sdwasdwsaswsdwdsadsw","wswsswddsawsdswsaswd","daswswsdsawaswdwswwa","sdaswsawsdwdswswsdwd","swddswssawddswdswdsa","dwsawsawdswsddadawws","sasdaswsswsadwwsdsad","daddwsaswsawdwsadsad","sawdswswsdsawdsswssw","wasdwsswdswssaswdswa","wswsdwswswssasasassa","asddsaswasswsswsddwd","dsdsswasdswdswsdwdsw","sawsdwsasddswdswsaws"]
    listaDificil!!numeroAleatorio

getNumeroAleatorio :: Int
getNumeroAleatorio = unsafePerformIO (getStdRandom (randomR (0, 14)))

getInput:: String -> IO()
getInput seq = do
    input2 <- getLine
    let sequenciaUsuario = input2
    print (verificaSequencia seq sequenciaUsuario)


timed :: Int -> IO a -> b -> IO (Either b a)
timed us act def = liftM (maybe (Left def) Right) (timeout us act)


main :: IO()
main = do
    let timeoutSequenciaFacil = 6000000
    let sequenciaDaVez = getSequenciaDaVezFacil
    mostraElemento sequenciaDaVez
    timeout timeoutSequenciaFacil (getInput (sequenciaDaVez) *> putStrLn "finished on time")
    putStrLn ""
    
    
