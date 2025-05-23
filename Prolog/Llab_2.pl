% a

% lista_nevida(L: list)
% model flux: (i)
% L: lista de intrare
% verifica daca lista L nu este vida

% Verificăm dacă lista nu este goală
lista_nevida([_|_]).


% adauga_sf(SF: list, L: list, R: list)
% model flux: (i, i, o)
% SF: secvența curentă de numere pare
% L: lista de intrare
% R: lista rezultată prin adăugarea secvenței SF la L

adauga_sf([], L, L).

adauga_sf([H|T1], L2, [H|T3]) :-
    adauga_sf(T1, L2, T3).


% numar_par(X)
% model flux: (i)
% X: numărul de verificat
% verifică dacă X este un număr par

% Predicat auxiliar pentru verificarea parității
numar_par(X) :-
    X mod 2 =:= 0.


% contor_mai_mare(A: int, B:int)
% model flux: (i, i)
% A: contorul curent
% B: contorul maxim
% verifica daca A este mai mare decat B

% Predicat auxiliar pentru a verifica dacă contorul curent este mai mare decât contorul maxim
contor_mai_mare(ContorCurent, ContorMaxim) :-
    ContorCurent > ContorMaxim.

% contor_neschimbat(A; int, B: int)
% model flux: (i, i)
% A: contorul curent
% B: contorul maxim
% verifica daca A este mai mic sau egal cu B

% Predicat auxiliar pentru a verifica dacă contorul curent este mai mic sau egal cu contorul maxim
contor_neschimbat(ContorCurent, ContorMaxim) :-
    ContorCurent =< ContorMaxim.


% cea_mai_lunga_secventa_pare(L: list, SecventaCurenta: list, ContorCurent: int, SecventaMaxima: list, ContorMaxim: int, MaxSecventa: list)
% model flux: (i, i, i, i, i, o)
% L: lista de intrare în care se caută cea mai lungă secvență de numere pare
% SecventaCurenta: secvența curentă de numere pare care se formează pe parcurs
% ContorCurent: contorul numărului de elemente din SecventaCurenta
% SecventaMaxima: cea mai lungă secvență de numere pare găsită până acum
% ContorMaxim: contorul numărului de elemente din SecventaMaxima
% MaxSecventa: lista rezultată care va conține cea mai lungă secvență de numere pare


% Cazul de bază pentru lista goală
cea_mai_lunga_secventa_pare([], []).

% Predicatul principal
cea_mai_lunga_secventa_pare(Lista, SecventaMaxima) :-
    lista_nevida(Lista),
    cea_mai_lunga_secventa_pare(Lista, [], 0, [], 0, SecventaMaxima).


% Cazul în care întâlnim un număr par
cea_mai_lunga_secventa_pare([X|T], SecventaCurenta, ContorCurent, SecventaMaxima, ContorMaxim, MaxSecventa) :-
    numar_par(X),
    ContorCurentNou is ContorCurent + 1,
    adauga_sf(SecventaCurenta, [X], SecventaCurentaNoua),
    cea_mai_lunga_secventa_pare(T, SecventaCurentaNoua, ContorCurentNou, SecventaMaxima, ContorMaxim, MaxSecventa).


% Cazul în care întâlnim un număr impar și secvența curentă este mai lungă decât secvența maximă
cea_mai_lunga_secventa_pare([_|T], SecventaCurenta, ContorCurent, _, ContorMaxim, MaxSecventa) :-
    contor_mai_mare(ContorCurent, ContorMaxim),
    cea_mai_lunga_secventa_pare(T, [], 0, SecventaCurenta, ContorCurent, MaxSecventa).

% Cazul în care întâlnim un număr impar și secvența maximă rămâne neschimbată
cea_mai_lunga_secventa_pare([_|T], _, ContorCurent, SecventaMaxima, ContorMaxim, MaxSecventa) :-
    contor_neschimbat(ContorCurent, ContorMaxim),
    cea_mai_lunga_secventa_pare(T, [], 0, SecventaMaxima, ContorMaxim, MaxSecventa).

% Cazul în care lista este goală la finalul recursiei și secvența curentă este mai lungă decât secvența maximă
cea_mai_lunga_secventa_pare([], SecventaCurenta, ContorCurent, _, ContorMaxim, MaxSecventa) :-
    contor_mai_mare(ContorCurent, ContorMaxim),
    MaxSecventa = SecventaCurenta.

% Cazul în care lista este goală la finalul recursiei și secvența maximă rămâne neschimbată
cea_mai_lunga_secventa_pare([], _, ContorCurent, SecventaMaxima, ContorMaxim, MaxSecventa) :-
    contor_neschimbat(ContorCurent, ContorMaxim),
    MaxSecventa = SecventaMaxima.





%b

% este_lista(L: list)
% model flux: (i)
% L: lista de intrare
% verifica daca L este o lista
este_lista([]).
este_lista([_|_]).


% inlocuieste_subliste(L: list, R: list)
% model flux: (i, o)
% L: lista de intrare
% R: lista rezultată în care sublistele au fost înlocuite cu cea mai lungă secvență de numere pare

% Înlocuiește sublistele dintr-o listă eterogenă cu cea mai lungă secvență de numere pare
inlocuieste_subliste([], []).
inlocuieste_subliste([H|T], [MaxSecventa|TResult]) :-
    este_lista(H),
    cea_mai_lunga_secventa_pare(H,MaxSecventa),
    inlocuieste_subliste(T,TResult).
inlocuieste_subliste([H|T], [H|TResult]) :-
    \+ este_lista(H),
    inlocuieste_subliste(T, TResult).



