:- module(blackjack, [init/0]).
:- use_module(database).

:- dynamic points/2.
:- dynamic previousCard/3.
:- dynamic cardNumber/2.
:- dynamic betcoin/1.

card('Ás', X):- X = 1.
card('Dois', X):- X = 2.
card('Três', X):- X = 3.
card('Quatro', X):- X = 4.
card('Cinco', X):- X = 5.
card('Seis', X):- X = 6.
card('Sete', X):- X = 7.
card('Oito', X):- X = 8.
card('Nove', X):- X = 9.
card('Dez', X):- X = 10.
card('Valete', X):- X = 10.
card('Rainha', X):- X = 10.
card('Rei', X):- X = 10.

cardNumber(player, 0).
cardNumber(dealer, 0).

victory(21).
limit(17).

points(player, 0).
points(dealer, 0).
betcoin(0).

end1:- write('A banca ganhou!'), incressBetcoin(-12), askPlay.
end2:- write('A banca atingiu mais de 21! Você ganhou!'), incressBetcoin(10), askPlay.
end3:- write('Sua pontuação chegou mais próximo de 21, Você ganhou!'), incressBetcoin(10), askPlay.
end4:- write('A banca chegou mais próximo de 21, A banca ganhou!'), incressBetcoin(-12), askPlay.
end5:- write('Empate!'), askPlay.
end6:- write('Obrigado por jogar conosco!'), save_player.
cls :- write('\33[2J').

save_player :-
    betcoin(B),
    writeln('Vamos Registar Seu Nome Para Salvar Suas Betcoins no Ranking 😊'),
    read(N),
    write('Seu score final foi de '), write(B), writeln(' Betcoins!'),
    add_player(N, B),
    halt.

init:- 
    cls, write('Bem vindo a mesa de apostas do BlackJack! \n'), 
    clearResult(player),
    clearResult(dealer),
    clearCarts(player),
    clearCarts(dealer), 
    playerTurn.


clearCarts(P):-
    retract(cardNumber(P,_)),
    assert(cardNumber(P,0)).

clearResult(P):-
    retract(points(P,_)),
    assert(points(P,0)).

playerTurn:- 
    write('\nDeseja Continuar Retirando Cartas? \n1. Sim\n2. Não \n\n'), 
    read(D), decide(D).

decide(D):- 
    D == 1, cls, getCard(player); 
    D == 2, dealerTurn.

dealerTurn:- 
    write('\n\nBanca está jogando...\n\n'), 
    getCard(dealer).

getCard(P):- 
    write('\n\nSua carta é... '), 
    obtainCard(P).

obtainCard(P):- 
    random_member(Card,['Ás','Dois','Três','Quatro'
                        ,'Cinco','Seis','Sete','Oito'
                        ,'Nove','Dez','Valete','Rainha','Rei']),
    write(Card), 
    cardNumber(P, Num), 
    assert(previousCard(P, Card, Num)),
    NewNum is Num + 1, 
    retract(cardNumber(P, _)),
    assert(cardNumber(P, NewNum)), 
    write('\n\nCartas: '), 
    showRecursiveCard(P, Num),
    card(Card, V), 
    addResult(P, V).

addResult(P, V):- 
    points(P, Old),
    chooseAceValue(V, Old, New),
    retract(points(P, _)), X is Old + New,
    assert(points(P, X)),
    write('Total: '), write(X), write('\n'),
    possibleEnd(P, X).

incressBetcoin(WinScore):- 
    betcoin(Old),
    retract(betcoin(_)),
    New is Old + WinScore,
    assert(betcoin(New)).

chooseAceValue(V, Old, New):- 
    V \== 1, New = V;
    Old >= 11, V == 1, New = 1;
    Old < 11, V == 1, New = 11.

showRecursiveCard(P, Num) :- 
    previousCard(P, T, Num), 
    Num == 0, 
    write(T), write('\n');
    previousCard(P, T, Num),
    Num \==0, 
    write(T), write(', '),
    NewNum is Num-1,
    showRecursiveCard(P, NewNum).

possibleEnd(P, X):- 
    victory(V), X > V, P == player, end1;
    victory(V), X = V, P == player, write('21! Vez da banca.'), dealerTurn, write('\n'), halt;
    victory(V), X < V, P == player, playerTurn, write('\n'), halt;
    victory(V), X > V, P == dealer, end2;
    victory(V), limit(L), X >= L, X =< V, P == dealer, end, write('\n'), halt;
    limit(L), X < L, P == dealer, getCard(P), write('\n'), halt.

end:- 
    points(player, X),
    points(dealer, Y),
    cls, write('\nResultado: \n\nVocê: '), write(X), 
    write('\nBanca: '), write(Y), write('\n\n'),
    finalCalculation(X, Y).

askPlay:- 
    write("Deseja jogar novamente? Sim [1] Não [0]"),
    read(Input),
    playAgain(Input).

playAgain(X):-
    (X == 1), init;
    (X == 0), end6.

finalCalculation(X, Y):- 
    X > Y, end3;
    X < Y, end4;
    X = Y, end5.