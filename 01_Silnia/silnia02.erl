-module(silnia02).

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


%%% Wywołanie:
% > erl
% Erlang/OTP 18 [erts-7.2.1] [source] [64-bit] [smp:8:8] [async-threads:16] [hipe] [kernel-poll:true]
%
% Eshell V7.2.1  (abort with ^G)
%
% 1> c(silnia02).
% {ok,silnia02}
%
% 2> silnia02:silnia(5).
% {ok,120}
%
% 3> silnia02:silnia(50).
% {ok,30414093201713378043612608166064768844377641568960512000000000000}
%
% 4> silnia02:silnia(-1).
% {error,badarg}
%
% 5> silnia02:silnia("500").
% {error,badarg}
%
% 6> silnia02:silnia(piecset).
% {error,badarg}
%
% 7> q().
% ok
                                                                                                               
