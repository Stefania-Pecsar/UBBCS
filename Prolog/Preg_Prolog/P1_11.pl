% 11
% a

descrescator([H1, H2 | Tail]) :-
    H1 > H2,
    descrescator([H2 | Tail]).

descrescator([_]).


crescator([H1, H2 | Tail]) :-
    H1 < H2,
    crescator([H2 | Tail]).

crescator([_]).


vale([H1, H2, H3 | Tail]) :-
    H1 > H2,
    descrescator([H2, H3 | Tail]),
    creste_din([H3 | Tail]).

vale([H1, H2 | Tail]) :-
    H1 > H2,
    creste_din([H2 | Tail]).


creste_din([H1, H2 | Tail]) :-
    H1 < H2,
    crescator([H2 | Tail]).
creste_din([_]).


% b

suma_alternanta(Lista,Suma):-
    suma_alternanta(Lista,1,0,Suma).

suma_alternanta([],_,SumaCurenta,SumaCurenta).

suma_alternanta([H|Tail],Poz,SumaCurenta,Suma):-
    Poz mod 2 =:= 1,
    NewSuma is SumaCurenta + H,
    Poz1 is Poz +1,
    suma_alternanta(Tail,Poz1,NewSuma,Suma).

suma_alternanta([H|Tail],Poz,SumaCurenta,Suma):-
    Poz mod 2 =\= 1,
    NewSuma is SumaCurenta - H,
    Poz1 is Poz + 1,
    suma_alternanta(Tail,Poz1,NewSuma,Suma).


