
%%%%%
card(R,S) :-
    card(R,S,[2,3,4,5,6,7,8,9,10,j,k,q,a],[h,c,d,s]).
card(R,S,Ranks,Suits) :-
    member(R, Ranks), member(S, Suits).
card([R,S]) :-
    card(R, S).

cards([X]) :-
    card(X),
    !.
cards([ X | Y ]) :-
    card(X),
    cards(Y), 
    !.

is_valid_hand(X) :-
    cards(X),
    is_set(X),
    length(X,5).

is_wild(2,_).
is_wild([R,S]) :-
    is_wild(R, S).

non_wild_card(R, S) :-
    card(R,S,[3,4,5,6,7,8,9,10,j,k,q,a],[h,c,d,s]).    
non_wild_card([R,S]) :-
    non_wild_card(R,S).

%%%%%
has_2(X, [X|Ys]) :-
    member(X, Ys), !.
has_2(X, [_|Ys]) :-
    has_2(X, Ys).

has_2s([X | _], Y) :-
    has_2(X, Y), !.
has_2s([_ | Xs], Y) :-
    has_2s(Xs, Y).

%%%%%
has_3(X, [X|Ys]) :-
    has_2(X, Ys), !.
has_3(X, [_|Ys]) :-
    has_3(X, Ys).

has_3s([X | _], Y) :-
    has_3(X, Y), !.
has_3s([_ | Xs], Y) :-
    has_3s(Xs, Y).

%%%%%
has_4(X, [X|Ys]) :-
    has_3(X, Ys), !.
has_4(X, [_|Ys]) :-
    has_4(X, Ys).

has_4s([X | _], Y) :-
    has_4(X, Y), !.
has_4s([_ | Xs], Y) :-
    has_4s(Xs, Y).

%%%%%
has_5(X, [X|Ys]) :-
    has_4(X, Ys), !.
has_5(X, [_|Ys]) :-
    has_5(X, Ys).

has_5s([X | _], Y) :-
    has_5(X, Y), !.
has_5s([_ | Xs], Y) :-
    has_5s(Xs, Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
with_two(Pred, [[2, _], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]) :-
    bagof(WC, non_wild_card(WC), WCs),
    with_two(Pred, [[R2, S2], [R3, S3], [R4, S4], [R5, S5]], WCs),
    !.
with_two(Pred, [[R1, S1], [2, _], [R3, S3], [R4, S4], [R5, S5]]) :-
    bagof(WC, non_wild_card(WC), WCs),
    with_two(Pred, [[R1, S1], [R3, S3], [R4, S4], [R5, S5]], WCs),
    !.
with_two(Pred, [[R1, S1], [R2, S2], [2, _], [R4, S4], [R5, S5]]) :-
    bagof(WC, non_wild_card(WC), WCs),
    with_two(Pred, [[R1, S1], [R2, S2], [R4, S4], [R5, S5]], WCs),
    !.
with_two(Pred, [[R1, S1], [R2, S2], [R3, S3], [2, _], [R5, S5]]) :-
    bagof(WC, non_wild_card(WC), WCs),
    with_two(Pred, [[R1, S1], [R2, S2], [R3, S3], [R5, S5]], WCs),
    !.
with_two(Pred, [[R1, S1], [R2, S2], [R3, S3], [R4, S4], [2, _]]) :-
    bagof(WC, non_wild_card(WC), WCs),
    with_two(Pred, [[R1, S1], [R2, S2], [R3, S3], [R4, S4]], WCs),
    !.
with_two(Pred, [C1, C2, C3, C4], [ C5 | _ ]) :-
    call(Pred, [C1, C2, C3, C4, C5]).
with_two(Pred, [C1, C2, C3, C4], [ _ | WCs ]) :-
    with_two(Pred, [C1, C2, C3, C4], WCs).

%%%

is_royal_flush([[R1, S], [R2, S], [R3, S], [R4, S], [R5, S]]) :-
    permutation([R1, R2, R3, R4, R5], [a, k, q, j, 10]),
    is_valid_hand([[R1, S], [R2, S], [R3, S], [R4, S], [R5, S]]),
    !.

%%%

is_wild_royal_flush([[R1, S1], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]) :-
    is_royal_flush([[R1, S1], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]),
    !.
is_wild_royal_flush(X) :-
    with_two(is_wild_royal_flush, X).

%%%%%

is_four_deuces([[R1, S1], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]) :-
    has_4(2, [R1, R2, R3, R4, R5]),
    is_valid_hand([[R1, S1],[R2, S2],[R3, S3],[R4, S4],[R5, S5]]),
    !.
    
%%%%%
is_4_of_kind([[R1, S1], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]) :-
    has_4s([R1, R2, R3, R4, R5], [R1, R2, R3, R4, R5]),
    is_valid_hand([[R1, S1],[R2, S2],[R3, S3],[R4, S4],[R5, S5]]),
    !.
is_4_of_kind(X) :-
    with_two(is_4_of_kind, X).

%%%%%
is_5_of_kind([[R, _], [R, _], [R, _], [R, _], [R, _]]).
is_5_of_kind(X) :-
    with_two(is_5_of_kind, X).

%%%%%
is_flush([[R1, S], [R2, S], [R3, S], [R4, S], [R5, S]]) :-
    is_valid_hand([[R1, S],[R2, S],[R3, S],[R4, S],[R5, S]]),
    !.
is_flush(X) :-
    with_two(is_flush, X).

%%%%%
is_3_of_kind([[R1, S1], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]) :-
    has_3s([R1, R2, R3, R4, R5], [R1, R2, R3, R4, R5]),
    is_valid_hand([[R1, S1],[R2, S2],[R3, S3],[R4, S4],[R5, S5]]),
    !.
is_3_of_kind(X) :-
    with_two(is_3_of_kind, X).

%%

is_full_house([[R1, S1], [R1, S2], [R1, S3], [R2, S4], [R2, S5]]) :-
    is_valid_hand([[R1, S1], [R1, S2], [R1, S3], [R2, S4], [R2, S5]]),
    !.
is_full_house([[R1, S1], [R1, S2], [R2, S3], [R2, S4], [R1, S5]]) :-
    is_valid_hand([[R1, S1], [R1, S2], [R2, S3], [R2, S4], [R1, S5]]),
    !.
is_full_house([[R1, S1], [R2, S2], [R1, S3], [R2, S4], [R1, S5]]) :-
    is_valid_hand([[R1, S1], [R2, S2], [R1, S3], [R2, S4], [R1, S5]]),
    !.
is_full_house([[R1, S1], [R2, S2], [R2, S3], [R1, S4], [R1, S5]]) :-
    is_valid_hand([[R1, S1], [R2, S2], [R2, S3], [R1, S4], [R1, S5]]),
    !.
is_full_house([[R2, S1], [R1, S2], [R2, S3], [R1, S4], [R1, S5]]) :-
    is_valid_hand([[R2, S1], [R1, S2], [R2, S3], [R1, S4], [R1, S5]]),
    !.
is_full_house([[R2, S1], [R2, S2], [R1, S3], [R1, S4], [R1, S5]]) :-
    is_valid_hand([[R2, S1], [R2, S2], [R1, S3], [R1, S4], [R1, S5]]),
    !.
is_full_house(X) :-
    with_two(is_full_house, X).

%%

is_straight([[R1, S1], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]) :-
    permutation([R1, R2, R3, R4, R5], [a, 2, 3, 4, 5]),
    is_valid_hand([[R1, S1],[R2, S2],[R3, S3],[R4, S4],[R5, S5]]),
    !.
is_straight([[R1, S1], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]) :-
    permutation([R1, R2, R3, R4, R5], [2, 3, 4, 5, 6]),
    is_valid_hand([[R1, S1],[R2, S2],[R3, S3],[R4, S4],[R5, S5]]),
    !.
is_straight([[R1, S1], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]) :-
    permutation([R1, R2, R3, R4, R5], [3, 4, 5, 6, 7]),
    is_valid_hand([[R1, S1],[R2, S2],[R3, S3],[R4, S4],[R5, S5]]),
    !.
is_straight([[R1, S1], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]) :-
    permutation([R1, R2, R3, R4, R5], [4, 5, 6, 7, 8]),
    is_valid_hand([[R1, S1],[R2, S2],[R3, S3],[R4, S4],[R5, S5]]),
    !.
is_straight([[R1, S1], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]) :-
    permutation([R1, R2, R3, R4, R5], [5, 6, 7, 8, 9]),
    is_valid_hand([[R1, S1],[R2, S2],[R3, S3],[R4, S4],[R5, S5]]),
    !.
is_straight([[R1, S1], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]) :-
    permutation([R1, R2, R3, R4, R5], [6, 7, 8, 9, 10]),
    is_valid_hand([[R1, S1],[R2, S2],[R3, S3],[R4, S4],[R5, S5]]),
    !.
is_straight([[R1, S1], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]) :-
    permutation([R1, R2, R3, R4, R5], [7, 8, 9, 10, j]),
    is_valid_hand([[R1, S1],[R2, S2],[R3, S3],[R4, S4],[R5, S5]]),
    !.
is_straight([[R1, S1], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]) :-
    permutation([R1, R2, R3, R4, R5], [8, 9, 10, j, q]),
    is_valid_hand([[R1, S1],[R2, S2],[R3, S3],[R4, S4],[R5, S5]]),
    !.
is_straight([[R1, S1], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]) :-
    permutation([R1, R2, R3, R4, R5], [9, 10, j, q, k]),
    is_valid_hand([[R1, S1],[R2, S2],[R3, S3],[R4, S4],[R5, S5]]),
    !.
is_straight([[R1, S1], [R2, S2], [R3, S3], [R4, S4], [R5, S5]]) :-
    permutation([R1, R2, R3, R4, R5], [10, j, q, k, a]),
    is_valid_hand([[R1, S1],[R2, S2],[R3, S3],[R4, S4],[R5, S5]]),
    !.
is_straight(X) :-
    with_two(is_straight, X).

%
is_straight_flush(X) :-
    is_straight(X),
    is_flush(X).

%%%%%%%%%%%%%%%

which_hand(X, Name) :-
    is_royal_flush(X),
    Name is 1,
    !.
which_hand(X, Name) :-
    is_four_deuces(X),
    Name is 2,
    !.
which_hand(X, Name) :-
    is_wild_royal_flush(X),
    Name is 3,
    !.
which_hand(X, Name) :-
    is_5_of_kind(X),
    Name is 4,
    !.
which_hand(X, Name) :-
    is_straight_flush(X),
    Name is 5,
    !.
which_hand(X, Name) :-
    is_4_of_kind(X),
    Name is 6,
    !.
which_hand(X, Name) :-
    is_full_house(X),
    Name is 7,
    !.
which_hand(X, Name) :-
    is_flush(X),
    Name is 8,
    !.
which_hand(X, Name) :-
    is_straight(X),
    Name is 9,
    !.
which_hand(X, Name) :-
    is_3_of_kind(X),
    Name is 10,
    !.
which_hand(_, Name) :-
    Name is 11,
    !.


