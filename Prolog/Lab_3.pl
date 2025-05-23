% submultime(Puncte: list, Submultime: list)
% model de flux: (i, o)
% Puncte: lista de intrare din care se formează submulțimile
% Submultime: submulțime generată pe baza listei de intrare

submultime([],[]).
submultime([H|Puncte], [H|Submultime]):-
    submultime(Puncte, Submultime).
submultime([_|Puncte], Submultime):-
    submultime(Puncte, Submultime).

% toate_suma(Lista: list, Suma: int)
% model de flux: (i, o)
% Lista: lista de intrare pentru care se calculează suma elementelor
% Suma: suma elementelor din lista de intrare

toate_suma([],0).
toate_suma([H|T], Suma):-
    toate_suma(T, Noua_Suma),
    Suma is Noua_Suma + H.


% verific(Submultime: list, Suma: int)
% model de flux: (i, i)
% Submultime: submulțimea pentru care se verifică suma elementelor
% Suma: suma dorită, cu care se compară suma elementelor din submulțime

verific(Submultime, Suma):-
    toate_suma(Submultime, Suma_submultime),
    Suma = Suma_submultime.

% gaseste_toate(Puncte: list, Toate_submultimile: list, S: int)
% model de flux: (i, o, i)
% Puncte: lista de intrare din care se caută submulțimi
% Toate_submultimile: lista tuturor submulțimilor care au suma egală cu S
% S: suma pe care trebuie să o aibă fiecare submulțime selectată

gaseste_toate(Puncte, Toate_submultimile, S):-
    findall(Submultime, (submultime(Puncte, Submultime), verific(Submultime, S)), Toate_submultimile).
