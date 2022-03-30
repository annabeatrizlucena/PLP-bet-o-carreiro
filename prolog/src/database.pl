:- module(database, [add_player/2, get_scores/2]).

add_player(N, S) :-
    atom_concat(N, ',', N1),
    atom_concat(N1, S, N2),
    open('../data/scores.csv', append, Stream),
    writeln(Stream, N2),
    close(Stream).

get_rows(L) :-
    csv_read_file('../data/scores.csv', Data, []),
    row_to_lists(Data, L).

nthcompare(N,<,A,B) :- nth1(N,A,X),nth1(N,B,Y), X @< Y.
nthcompare(_,>,_,_).    

get_scores(L, R1):-
    get_rows(L),
    predsort(nthcompare(2), L, R),
    reverse(R, R1).

row_to_lists(R, L) :-
    maplist(row_to_list, R, L).

row_to_list(R, L):-
    R =..[row|L].