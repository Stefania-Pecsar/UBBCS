% 11
% a

este_prim(2).  % 2 este prim
este_prim(N) :-
    N > 2,
    \+ exista_divizor(N, 2).  % Verifică dacă există un divizor între 2 și sqrt(N)

% Verifică dacă există un divizor al lui N în intervalul [2, sqrt(N)]
exista_divizor(N, I) :-
    I * I =< N,          % Verificăm până la rădăcina pătrată a lui N
    N mod I =:= 0.       % Verificăm dacă I este divizor al lui N
exista_divizor(N, I) :-
    I * I =< N,          % Continuăm cu I > 2
    I2 is I + 1,
    exista_divizor(N, I2). % Continuăm verificarea pentru următorul I

% Adaugă de două ori numerele prime într-o listă
adauga_prime_de_2_ori([], []).  % Lista goală rămâne goală
adauga_prime_de_2_ori([H|T], [H,H|Rest]) :-
    este_prim(H),  % Dacă H este prim, adaugă-l de două ori
    adauga_prime_de_2_ori(T, Rest).
adauga_prime_de_2_ori([H|T], [H|Rest]) :-
    \+ este_prim(H),  % Dacă H nu este prim, păstrează-l o dată
    adauga_prime_de_2_ori(T, Rest).
