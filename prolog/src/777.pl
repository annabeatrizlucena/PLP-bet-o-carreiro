:- use_module(database).

start:-
    writeln('Bem Vindo ao Jogo 707070! Se Perder 70 de Novo!'),
    writeln('        Você Começa Com $50 BetCoins!'),
    writeln('-=-=-=-=-=-=-=-=-=-X><X-=-=-=-=-=-=-=-=-=-=-=-=-'),
    writeln('Você Ganha Com as Seguintes Combinações:'),
    writeln('1. 🍫     🍫    🍫         pays $250'),
    writeln('2. 🔔     🔔    🔔    🍫   pays $20'),
    writeln('3. 💩     💩    💩    🍫   pays $14'),
    writeln('4. 🍊     🍊    🍊    🍫   pays $10'),
    writeln('5. 🍒     🍒    🍒         pays $7'),
    writeln('6. 🍒     🍒               pays $5'),
    writeln('7. 🍒                      pays $2'),
    play(50, _, _),
    halt.

cls :- write('\33[2J').

play(B, O, F):-
    writeln('Você quer Jogar? (S/N)'),
    read(O),
    (O == 'S' -> (
        cls,
        playRound(B, _, _, _, _, R),
        play(R, _, F));

        cls,
        writeln('Vamos Registar Seu Nome Para Salvar Suas Betcoins no Ranking 😊'),
        read(N),
        write('Seu score final foi de '), write(B), writeln(' Betcoins!'),
        add_player(N, B),
        halt
    ).

playRound(Q,X,Y,Z,P,R):-
    Emojis = ["🍫","🔔","💩","🍊","🍒"],
    random_between(0,4,X),
    random_between(0,4,Y),
    random_between(0,4,Z),
    nth0(X,Emojis,X1),
    nth0(Y,Emojis,Y1),
    nth0(Z,Emojis,Z1),
    (
        (win250(X1, Y1, Z1), P is 250);
        (win20(X1, Y1, Z1), P is 20);
        (win14(X1, Y1, Z1), P is 14);
        (win10(X1, Y1, Z1), P is 10);
        (win7(X1, Y1, Z1), P is 7);
        (win5(X1, Y1, Z1), P is 5);
        (win2(X1, Y1, Z1), P is 2);
        (P is -1)
    ),
    write('Você conseguiu '), write(P), write(' Betcoins! com '), write(X1), write(' '), write(Y1), write(' '), write(Z1), writeln('!'),
    R is Q+P.

win250("🍫", "🍫", "🍫").
win20("🔔", "🔔", "🔔").
win20("🔔", "🔔", "🍫").
win14("💩", "💩", "💩").
win14("💩", "💩", "🍫").
win10("🍊", "🍊", "🍊").
win10("🍊", "🍊", "🍫").
win7("🍒", "🍒", "🍒").
win5("🍒", "🍒", _).
win5(_, "🍒", "🍒").
win2("🍒", _, _).
win2(_, "🍒", _).
win2(_, _, "🍒").

