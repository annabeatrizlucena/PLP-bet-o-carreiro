:- module(util, [print_score/1]).

print_score([]).
print_score([Player|Score]):-
    print_player(Player),
    print_score(Score).

print_player([Name|Score]):-
    write(Name),
    write(' |     '),
    nth0(0, Score, Score0),
    writeln(Score0).