% 10
% a

insert([], _, _, []).
insert([H|T], Val, Pos, [H|Rest]) :-
    Pos > 1,
    NextPos is Pos - 1,
    insert(T, Val, NextPos, Rest).
insert([H|T], Val, 1, [H, Val|T]).

% Predicat pentru a adăuga valoarea la pozițiile 1, 3, 7, 15, ...
adauga_1([], _, _, []).
adauga_1(Lista, Val, Poz, R) :-
    insert(Lista, Val, Poz, TList),
    NextPoz is 2 * Poz+1, % Următoarea poziție este 2^n +1
    adauga_1(TList, Val, NextPoz, R).
