#!/usr/bin/env swipl -f -q

:- initialization main.

print_name(1) :-
    write("royal flush").
print_name(2) :-
    write("4 deuces").
print_name(3) :-
    write("wild royal flush").
print_name(4) :-
    write("5 of a kind").
print_name(5) :-
    write("straight flush").
print_name(6) :-
    write("4 of a kind").
print_name(7) :-
    write("full house").
print_name(8) :-
    write("flush").
print_name(9) :-
    write("straight").
print_name(10) :-
    write("3 of a kind").
print_name(11) :-
    write("none").

print_example(X) :-
    writef("%p = ", [X]),
    which_hand(X, Name),
    print_name(Name),
    writef("\n", []).

main :-
    consult("deuceswild.pl"),
    print_example([[3, h], [5, c], [4, s], [7, d], [6, c]]),
    print_example([[a, h], [3, c], [3, s], [a, d], [a, c]]),
    print_example([[a, h], [k, h], [a, s], [3, d], [a, c]]),
    print_example([[a, h], [k, h], [2, s], [3, d], [a, c]]),
    halt(0).
