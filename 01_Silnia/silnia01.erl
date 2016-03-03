%% Wszystkie funkcje muszą należeć do jakiegoś modułu (coś jak Java)
-module(silnia01).

%% Domyślnie wszystkie funkcje są prywatne. Tutaj wymieniamy funkcje
%% do eksportu. Liczba po / to liczba parametrów funkcji.

-export([silniaA/1,silniaB/1]).

%% Implementacja naiwna. Rekurencja nie jest końcowa. Można przepełnić
%% stos (teoretycznie) przez wyczerpanie RAMu. 
%% Można sobie na takie funkcje pozwolić, jeżeli nie są zapętlone "na
%% amen"
silniaA(0) ->
    1;                % Wszystkie warianty poza ostatnim kończymy ";"

silniaA(N) ->
    N*silniaA(N-1).   % Ostatni wariant kończymy "."

%% Implementacja poprawna, z akumulatorem. Można zrobić
%% optymalizację rekurencji końcowej. Nie sprawdzamy poprawności
%% argumentu.
silniaB(N) ->
    silniaB(N,1).

%% Prywatna funkcja pomocnicza
%% Jest to ZUPEŁNIE INNA funkcja, bo ma inną liczbę parametrów.
%% Gdybyśmy ją chcieli wyeksportować, to byłoby to silniaB/2
silniaB(0,Akumulator) ->
    Akumulator;

silniaB(N,Akumulator) ->
    silniaB(N-1,N*Akumulator).
