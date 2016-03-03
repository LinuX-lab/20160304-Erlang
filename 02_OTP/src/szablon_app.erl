-module(szablon_app).

-behaviour(application).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Eksportowane callbacki aplikacji
%%
-export([start/2,stop/1]).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Callback do startu aplikacji
%%
start(Typ,Argumenty) ->
    io:format("APP:~p start(~p,~p)~n",[self(),Typ,Argumenty]),
    szablon_supervisor:start().

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Callback po stopie aplikacji
%%
stop(Stan) ->
    io:format("APP:~p stop(~p)~n",[self(),Stan]),
    ok.

