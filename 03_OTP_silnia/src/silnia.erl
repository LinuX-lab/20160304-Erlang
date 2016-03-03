-module(silnia).

-export([silnia/1]).

%% Implementacja z obsługą błędów
%% Ta wersja będzie wywołąna tylko dla liczb >=0
silnia(N) when is_number(N), N>=0 ->
    {ok,silnia_(N,1)};

%% Ta wersja - dla wszystkich pozostałych typów
%% argumentów, w tym liczb <0, stringów, itd.
silnia(_) ->
    {error,badarg}.

%% Prywatna funkcja pomocnicza
silnia_(0,Akumulator) ->
    Akumulator;
silnia_(N,Akumulator) ->
    silnia_(N-1,N*Akumulator).

