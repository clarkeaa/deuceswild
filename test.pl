#!/usr/bin/env swipl -f -q

:- initialization main.

:- begin_tests(deuceswild).

test(card, [nondet]) :-
    card(2, h).

test(cards) :-
    cards([[2,h], [j,c]]).

test(is_valid_hand_simple) :-
    is_valid_hand([[a, h], [k, h], [q, h], [j, h], [10, h]]).

test(is_valid_hand_not_card) :-
    not(is_valid_hand([[a, q], [k, h], [q, h], [j, h], [10, h]])).

test(is_valid_hand_not_set) :-
    not(is_valid_hand([[k, h], [k, h], [q, h], [j, h], [10, h]])).

test(is_valid_hand_not_5) :-
    not(is_valid_hand([[k, h], [q, h], [j, h], [10, h]])).

test(is_wild) :-
    is_wild(2, c).

test(has_2) :-
    has_2(1, [0,1,0,0,1]).

test(has_2s) :-
    has_2s([3,1], [0,1,0,0,1]).

test(has_3) :-
    has_3(1, [0,1,0,0,1,1]).

test(has_3s) :-
    has_3s([2,1], [0,1,0,0,1,1]).

test(has_4) :-
    has_4(1, [0,1,0,0,1,1,0,1]).

test(has_4s) :-
    has_4s([2,1], [0,1,0,0,1,1,1]).

test(has_5) :-
    has_5(1, [0,1,0,0,1,1,0,1,1]).

test(has_5s) :-
    has_4s([2,1], [0,1,0,0,1,1,1,0,1]).

%%% is_royal_flush

test(is_royal_flush_simple) :-
    is_royal_flush([[a, h], [k, h], [q, h], [j, h], [10, h]]).

test(is_royal_flush_simple_not_rank) :-
    not(is_royal_flush([[3, h], [k, h], [q, h], [j, h], [10, h]])).

test(is_royal_flush_simple_not_suit) :-
    not(is_royal_flush([[a, c], [k, h], [q, h], [j, h], [10, h]])).

%%%%

test(is_four_deuces) :-
    is_four_deuces([[a, h], [2, c], [2, h], [2, d], [2, s]]).

%%%%

test(is_5_of_kind) :-
    is_5_of_kind([[a, h], [a, c], [a, s], [a, d], [2, s]]).

%%%%

test(is_wild_royal_flush_one_2) :-
    is_wild_royal_flush([[a, h], [2, c], [q, h], [j, h], [10, h]]).

test(is_wild_royal_flush_two_2) :-
    is_wild_royal_flush([[a, h], [2, c], [2, s], [j, h], [10, h]]).

%%% is_4_of_kind

test(is_4_of_kind_simple) :-
    is_4_of_kind([[a, h], [k, h], [a, s], [a, d], [a, c]]).

test(is_4_of_kind_one_2) :-
    is_4_of_kind([[a, h], [k, h], [2, s], [a, d], [a, c]]).

test(is_4_of_kind_two_2) :-
    is_4_of_kind([[a, h], [k, h], [2, s], [2, d], [a, c]]).

test(is_4_of_kind_three_2) :-
    is_4_of_kind([[a, h], [2, h], [2, s], [2, d], [3, c]]).

test(is_4_of_kind_four_2) :-
    is_4_of_kind([[a, h], [2, h], [2, s], [2, d], [2, c]]).

%%% is_3_of_kind

test(is_3_of_kind_simple) :-
    is_3_of_kind([[a, h], [k, h], [a, s], [3, d], [a, c]]).

test(is_3_of_kind_one_2) :-
    is_3_of_kind([[a, h], [2, c], [3, c], [3, d], [a, c]]).

test(is_3_of_kind_two_2) :-
    is_3_of_kind([[a, h], [2, c], [3, c], [4, d], [2, h]]).

test(is_3_of_kind_three_2) :-
    is_3_of_kind([[a, h], [2, c], [3, c], [2, d], [2, h]]).

test(is_3_of_kind_four_2) :-
    is_3_of_kind([[a, h], [2, c], [2, s], [2, d], [2, h]]).

%%% is_flush

test(is_flush_simple) :-
    is_flush([[a, h], [k, h], [10, h], [3, h], [q, h]]).

test(is_flush_one_2) :-
    is_flush([[a, h], [2, c], [10, h], [3, h], [q, h]]).

test(is_flush_two_2) :-
    is_flush([[a, h], [2, c], [2, s], [3, h], [q, h]]).

test(is_flush_three_2) :-
    is_flush([[a, h], [2, c], [2, s], [2, d], [q, h]]).

test(is_flush_four_2) :-
    is_flush([[a, h], [2, c], [2, s], [2, d], [2, h]]).

%%% is_full_house

test(is_full_house_simple) :-
    is_full_house([[a, h], [3, c], [3, s], [a, d], [a, c]]).

test(is_full_house_simple_not_first) :-
    is_full_house([[3, c], [a, h], [3, s], [a, d], [a, c]]).

test(is_full_house_simple_not_first_two) :-
    is_full_house([[3, c], [3, s], [a, h], [a, d], [a, c]]).

test(is_full_house_simple_one_2) :-
    is_full_house([[3, c], [3, s], [a, h], [2, d], [a, c]]).

%%% is_staight

test(is_straight_simple) :-
    is_straight([[3, h], [5, c], [4, s], [7, d], [6, c]]).

test(is_straight_one_2) :-
    is_straight([[3, h], [5, c], [2, s], [7, d], [6, c]]).

test(is_straight_two_2) :-
    is_straight([[3, h], [2, c], [2, s], [7, d], [6, c]]).

test(is_straight_not_two_2) :-
    not(is_straight([[3, h], [2, c], [2, s], [7, d], [q, c]])).

%%% is_staight_flush

test(is_straight_flush_simple) :-
    is_straight_flush([[3, h], [5, h], [4, h], [7, h], [6, h]]).

test(is_straight_one_2) :-
    is_straight_flush([[7, h], [5, h], [4, h], [2, c], [6, h]]).

:- end_tests(deuceswild).

main :-
    consult("deuceswild.pl"),
    run_tests,
    halt(0).
