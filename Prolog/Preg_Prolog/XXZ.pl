% Predicat pentru a verifica dacă un număr este par
par(X) :- 0 is X mod 2.

% Predicat pentru a elimina secvențele de numere negative dintr-o listă
elimina_negative([], []).  % Lista goală rămâne goală.
elimina_negative([H|T], Rez) :-
    H >= 0,  % Dacă H nu este negativ, îl păstrăm.
    elimina_negative(T, RezTail),
    Rez = [H|RezTail].
elimina_negative([H|T], Rez) :-
    H < 0,  % Dacă H este negativ, îl ignorăm.
    elimina_negative(T, Rez).

% Predicat pentru a păstra doar numerele pare
numere_pare([], []).  % Lista goală rămâne goală.
numere_pare([H|T], [H|Rez]) :-
    par(H),  % Dacă H este par, îl păstrăm.
    numere_pare(T, Rez).
numere_pare([H|T], Rez) :-
    \+ par(H),  % Dacă H nu este par, îl ignorăm.
    numere_pare(T, Rez).

% Predicat pentru a dubla numerele pare din listă
dubla([], []).  % Lista goală rămâne goală.
dubla([H|T], [H, H|Rez]) :-  % Dublăm H.
    dubla(T, Rez).

% Predicat principal care combină toate operațiile
procesa_lista(Input, Rezultat) :-
    elimina_negative(Input, ListaFaraNegative),  % Eliminăm negativele.
    numere_pare(ListaFaraNegative, NumerePare),  % Păstrăm doar numerele pare.
    dubla(NumerePare, Rezultat).  % Dublăm numerele pare.
