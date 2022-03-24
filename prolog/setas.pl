getEasyPhase(X) :-
    random_between(0,14, R),
    Lista = ["aaswd", "aaswd", "wdsaw", "swdaa", "dwsdd", "wswaa", "dsaws", "sswda", "sdaws", "ddasw", "awsdw", "sadws", "dawsw", "sawds", "awdsa", "wasda"],
    nth0(R, Lista, X).

getMiddlePhase(X) :-
    random_between(0,14, R),
    Lista = ["wdsaawd", "awdswsd", "wsadwsd", "awsdwsd", "awaaaws", "dsadwsw", "swdsadw", "dswaswd", "wsaswsw", "awswwwd", "dawdwsd", "wsdawsw", "awaawwd", "ssadwsw", "asdwswa"],
    nth0(R, Lista, X).
    
getHardPhase(X) :-
    random_between(0,14, R),
    Lista = ["asswswsdsa", "sdwasdwsas", "wswsswddsa", "daswswsdsa", "sdaswsawsd", "swddswssaw", "dwsawsawds", "asdaswssws", "sawdwsadsd", "sawdswswsd", "wasdwsswds", "wswsdwswsw", "asddsaswas", "dsdsswasds", "sawsdwsasd"],
    nth0(R, Lista, X).

verificaCaractere(X,L) :- L = [X|_].
verificaCaractere(X,L) :- L = [_|Z], verificaCaractere(X,Z).

printCaractere([X|L]) :-
    writeln(X),
    sleep(2),
    printCaractere(L).

initArrowsGame :-
  writeln("Bem Vindo ao Jogo das Setinhas ⬅️⬆️➡️"),
  writeln(" "),
  writeln("Escolha sua fase:"),
  writeln("[1] Fácil"),
  writeln("[2] Médio"),
  writeln("[3] Difícil"),
  writeln("[4] Sair").

cls :- write('\33\[2J').

getPhase(1,X) :- getEasyPhase(X).
getPhase(2,X) :- getMiddlePhase(X).
getPhase(3,X) :- getHardPhase(X).

main :-
    initArrowsGame,
    writeln(" "),
    read(A),
    getPhase(A,X),
    string_chars(X,Lista),
    printCaractere(Lista), halt.
    