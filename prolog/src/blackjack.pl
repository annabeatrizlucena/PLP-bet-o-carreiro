:- dynamic points/2.
:- dynamic previousCard/3.
:- dynamic cardNumber/2.

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

end1:- write('A banca ganhou!').
end2:- write('A banca atingiu mais de 21! Você ganhou!').
end3:- write('Sua pontuação chegou mais próximo de 21, Você ganhou!').
end4:- write('A banca chegou mais próximo de 21, A banca ganhou!').
end5:- write('Empate!').

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
    victory(V), X > V, P == player, end1, write('\n'), halt;
    victory(V), X = V, P == player, write('21! Vez da banca.'), dealerTurn, write('\n'), halt;
    victory(V), X < V, P == player, playerTurn, write('\n'), halt;
    victory(V), X > V, P == dealer, end2, write('\n'), halt;
    victory(V), limit(L), X >= L, X =< V, P == dealer, end, write('\n'), halt;
    limit(L), X < L, P == dealer, getCard(P), write('\n'), halt.

end:- 
    points(player, X),
    points(dealer, Y),
    cls, write('\nResultado: \n\nVocê: '), write(X), 
    write('\nBanca: '), write(Y), write('\n\n'),
    finalCalculation(X, Y).

finalCalculation(X, Y):- 
    X > Y, end3;
    X < Y, end4;
    X = Y, end5.