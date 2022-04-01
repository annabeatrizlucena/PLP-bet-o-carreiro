:- module(blackjack, [init/0]).
:- use_module(database).

:- dynamic points/2.
:- dynamic previousCard/3.
:- dynamic cardNumber/2.
:- dynamic betCoins/2.


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
betCoins(player,'0').

end1(P):- write('A banca ganhou!\n'),askPlay(P).
end2(P):- write('A banca atingiu mais de 21! Você ganhou!\n'),askPlay(P).
end3(P):- write('Sua pontuação chegou mais próximo de 21, Você ganhou!\n'),askPlay(P).
end4(P):- write('A banca chegou mais próximo de 21, A banca ganhou!\n'),askPlay(P).
end5(P):- write('Empate!\n'),askPlay(P).
end6:- write('Obrigado por jogar conosco!').
cls :- write('\33[2J').


init:- 
    cls, write('Bem vindo a mesa de apostas do BlackJack! \n'), 
    playerTurn.

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
    victory(V), X > V, P == player,addBetCoins(P,0), end1(P);
    victory(V), X = V, P == player, write('21! Vez da banca.'), dealerTurn, write('\n'), halt;
    victory(V), X < V, P == player, playerTurn, write('\n'), halt;
    victory(V), X > V, P == dealer,addBetCoins(P,1), end2(P);
    victory(V), limit(L), X >= L, X =< V, P == dealer, end, write('\n'), halt;
    limit(L), X < L, P == dealer, getCard(P), write('\n'), halt.

end:- 
    points(player, X),
    points(dealer, Y),
    cls, write('\nResultado: \n\nVocê: '), write(X), 
    write('\nBanca: '), write(Y), write('\n\n'),
    finalCalculation(player,X, Y).

askPlay(P):- 
    write("Deseja jogar novamente? Sim [1] Não [0]"),
    read(Input),
    playAgain(Input,P).

registerScore(P):-
    betCoins(P,S),
    writeln('Vamos Registar Seu Nome Para Salvar Suas Betcoins no Ranking 😊'),
    read(N),
    write('Seu score final foi de '), write(S), writeln(' Betcoins!\n'),
    add_player(N, S).

playAgain(X,P):-
    (X == 1 -> (init); registerScore(P)).

finalCalculation(P,X, Y):- 
    X > Y, addBetCoins(P,1),end3(P);
    X < Y,addBetCoins(P,0), end4(P);
    X = Y, end5(P).

addBetCoins(P, W):- 
    betCoins(P, Old),
    calcBetCoins(Old, W,New),
    retract(betCoins(P, _)),
    assert(betCoins(P, New)).  

calcBetCoins(Old,W,New):-
    atom_number(Old, Old1),
    W = 1, New = Old1 + 10;
    W = 0, New = Old1 - 12.
