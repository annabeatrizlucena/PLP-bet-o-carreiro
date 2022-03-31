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


validateSequence(A,A).

printCharacter([X|L]) :-
    writeln(X),
    sleep(2),
    printCharacter(L).

initArrowsGame :-
  writeln("Bem Vindo ao Jogo das Setinhas ⬅️⬆️➡️"),
  writeln(" "),
  writeln("Escolha sua fase:"),
  writeln("[1] Fácil"),
  writeln("[2] Médio"),
  writeln("[3] Difícil"),
  writeln("[4] Sair").

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
    halt.

compareSequence :-
    getOption(1,X),
    read(Y),
    validateSequence(X,Y).

getUserInput(Time,X) :-
    writeln("\nDigite sua resposta:\n"),
    current_input(I),
    wait_for_input([I], [Input], Time),
    read_string(Input, _, String),
    X = String; X = "\nO seu tempo acabou :(".

cls :- write('\33\[2J').

getPhase(1,X) :- getEasyPhase(X).
getPhase(2,X) :- getMiddlePhase(X).
getPhase(3,X) :- getHardPhase(X).

main :-
    initArrowsGame,
    read(Input),
    getOption(Input, X),
    getUserInput(5,X).
    