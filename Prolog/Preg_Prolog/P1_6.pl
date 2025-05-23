%6
%a

nr_ap(_,[],0).

nr_ap(X,[X|Tail],R):-
    nr_ap(X,Tail,R1),
    R is R1 + 1.

nr_ap(E,[H|Tail],R):-
    E\=H,!,
    nr_ap(E,Tail,R).


elimi([],_,[]).

elimi([H|Tail],C,R):-
    nr_ap(H,C,Rez),
    Rez=1,
    elimi(Tail,C,R1),
    R=[H|R1].

elimi([H|Tail],C,R):-
    nr_ap(H,C,Rez),
    Rez>1,
    elimi(Tail,C,R).

printare(L, Rez) :-
    elimi(L, L, Rez).

%b

max([X],X).

max([H|Tail],Max):-
    max(Tail,MaxT),
    Max is max(H,MaxT).

elimina([],_,[]).

elimina([H|Tail],E,Rez):-
    H=:=E,
    elimina(Tail,E,Rez).

elimina([H|Tail],E,[H|Rez]):-
    H=\=E,
    elimina(Tail,E,Rez).

elimina_max(l,Rez):-
    max(L,Max),
    elimina(L,Max,Rez).
