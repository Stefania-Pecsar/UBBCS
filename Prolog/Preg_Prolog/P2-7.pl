% 7
% a

% Definiti un predicat care determina produsul unui numar reprezentat
% cifra cu cifra intr-o lista cu o anumita cifra. De ex: [1 9 3 5 9 9] *
% 2 => [3 8 7 1 9 8]
%
% inmultire(L:list, Cifra:Integer, Transport:Integer, Rez:list)
% (i,i,i,o) - det.
inmultire([], _, 0, []):-!.
inmultire([H|T], Cifra, Transport, [Produs|Result]):-
    inmultire(T, Cifra, TransportCurent, Result),
    Prod is H * Cifra + TransportCurent,
    Produs is Prod mod 10,
    Transport is Prod // 10.

main1(L, Cifra, Result):-
    inmultire(L, Cifra, Transport, Rez),
    (Transport \= 0 -> Result = [Transport|Rez]; Result = Rez   ).
