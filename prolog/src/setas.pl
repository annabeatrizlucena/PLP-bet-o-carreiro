:- module(setas, [initArrows/0]).
:- use_module(database).

:- dynamic betcoin/1.

betcoin(0).

getEasyPhase(X) :-
    random_between(0,14, R),
    Lista = ['aaswd', 'aaswd', 'wdsaw', 'swdaa', 'dwsdd', 'wswaa', 'dsaws', 'sswda', 'sdaws', 'ddasw', 'awsdw', 'sadws', 'dawsw', 'sawds', 'awdsa', 'wasda'],
    nth0(R, Lista, X).

getMiddlePhase(X) :-
    random_between(0,14, R),
    Lista = ['wdsaawd', 'awdswsd', 'wsadwsd', 'awsdwsd', 'awaaaws', 'dsadwsw', 'swdsadw', 'dswaswd', 'wsaswsw', 'awswwwd', 'dawdwsd', 'wsdawsw', 'awaawwd', 'ssadwsw', 'asdwswa'],
    nth0(R, Lista, X).
    
getHardPhase(X) :-
    random_between(0,14, R),
    Lista = ['asswswsdsa', 'sdwasdwsas', 'wswsswddsa', 'daswswsdsa', 'sdaswsawsd', 'swddswssaw', 'dwsawsawds', 'asdaswssws', 'sawdwsadsd', 'sawdswswsd', 'wasdwsswds', 'wswsdwswsw', 'asddsaswas', 'dsdsswasds', 'sawsdwsasd'],
    nth0(R, Lista, X).


validateSequence(A,A).

printCharacter([]).
printCharacter([X|L]) :-
    writeln(X),
    sleep(2),
    printCharacter(L).

initArrowsGame :-
  writeln('Bem Vindo ao Jogo das Setinhas ⬅️⬆️➡️'),
  writeln(' '),
  writeln('Escolha sua fase:'),
  writeln('[1] Fácil'),
  writeln('[2] Médio'),
  writeln('[3] Difícil'),
  writeln('[4] Sair').

getOption(1,X) :-
    getEasyPhase(X),
    string_chars(X,List),
    printCharacter(List).

getOption(2,X) :-
    getMiddlePhase(X),
    string_chars(X,List),
    printCharacter(List).

getOption(3,X) :-
    getHardPhase(X),
    string_chars(X,List),
    printCharacter(List).

getOption(4,X) :-
    save_player,
    X = 1,
    halt.

save_player :-
    betcoin(B),
    writeln('Vamos Registar Seu Nome Para Salvar Suas Betcoins no Ranking 😊'),
    read(N),
    write('Seu score final foi de '), write(B), writeln(' Betcoins!'),
    add_player(N, B),
    halt.

compareSequence(Input, X) :-
    getOption(Input,X),
    writeln('Digite sua resposta:\n'),
    read(Y),
    (X == Y -> incressBetcoin(10), writeln('Resposta Correta!!'); writeln('Resposta Incorreta!')).

cls :- write('\33\[2J').

getPhase(1,X) :- getEasyPhase(X).
getPhase(2,X) :- getMiddlePhase(X).
getPhase(3,X) :- getHardPhase(X).

initArrows :-
    initArrowsGame,
    read(Input),
    compareSequence(Input,X),
    initArrows.

incressBetcoin(WinScore):- 
    betcoin(Old),
    write('\n\nVocê ganhou '), write(Old), write(' pontos!\n'),
    retract(betcoin(_)),
    New is Old + WinScore,
    assert(betcoin(New)).