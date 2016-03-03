-module(szablon_supervisor).

-behaviour(supervisor).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Eksportowany callback SUPERVISOR-a
%%
-export([init/1]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Eksportowane funkcje użytkownika
%%
-export([start/0]).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Uruchomienie supervisora
%%
start()->
    io:format("SUP:~p start()~n",[self()]),
    supervisor:start_link({local,'Szablon supervisor'},?MODULE,[]).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Callback konfiguracji supervisora
%%
init(Arg)->
    io:format("SUP:~p init(~p)~n",[self(),Arg]),

    Strategia = #{
      strategy => one_for_one,
      intensity => 1,
      period => 60
     },

    Serwer = #{
      id => 'Szablon serwer',
      start => {szablon_serwer,start,[link]},
      shutdown => 5,
      type => worker,
      modules => [szablon_serwer],
      restart => permanent
     },
    
    {ok,{Strategia,[Serwer]}}.
