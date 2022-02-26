import Text.Printf (printf)
import Control.Monad.Except (replicateM)
import BlackJack

main :: IO()
main = do
    printf "Quantos jogadores irao participar? (Mínimo 2)"
    numeroJogadores <- getLine
    let numJogadores = read numeroJogadores

    printf "Insira o nome do(s) Jogador(es):"
    listaJogadores <- replicateM numJogadores getLine
    print (playBlackJack listaJogadores numJogadores)