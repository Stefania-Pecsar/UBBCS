% 13
% a

adaugă_divizori([], []).

% Recursiv: pentru un element H, adăugăm divizorii acestuia după H
adaugă_divizori([H|Tail], [H|Rez]) :-
    divizori(H, Divizori),  % Calculăm divizorii lui H
    adaugă_divizori_lista(Divizori, _),  % Procesăm divizorii
    adaugă_divizori(Tail, RestRez),  % Procesăm restul listei
    adaugă_divizori_lista(RestRez, Rez).

% Calculăm divizorii unui număr
divizori(N, Divizori) :-
    divizori_aux(N, 1, Divizori).

% Funcție auxiliară pentru găsirea divizorilor
divizori_aux(N, N, [N]) :-  % Dacă am ajuns la N, adăugăm N ca divizor
    N > 0.
divizori_aux(N, D, [D|Rest]) :-
    D < N,                  % Continuăm să căutăm până la N
    N mod D =:= 0,          % Verificăm dacă D este divizor al lui N
    Next is D + 1,           % Creștem D pentru următorul divizor
    divizori_aux(N, Next, Rest).
divizori_aux(N, D, Rest) :-  % Dacă D nu este divizor, continuăm cu următorul număr
    D < N,
    Next is D + 1,
    divizori_aux(N, Next, Rest).

% Adăugăm divizorii într-o listă
adaugă_divizori_lista([], []).  % Dacă nu avem divizori, returnăm o listă goală
adaugă_divizori_lista([D|Tail], [D|Rest]) :-
    adaugă_divizori_lista(Tail, Rest).
