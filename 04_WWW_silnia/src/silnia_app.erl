-module(silnia_app).

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
    
    Dispatch = cowboy_router:compile(
		 [
		  {'_', [
			 {"/:liczba", [{liczba, int}], silnia_handler, []}
			]}
		 ]
		),

    {ok, _} = cowboy:start_http(myhttp,50,
				[{port, 8000}, {max_connections, 32}],
				[{env, [{dispatch, Dispatch}]}]
			       ),
    
    silnia_supervisor:start().
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Callback po stopie aplikacji
%%
stop(Stan) ->
    io:format("APP:~p stop(~p)~n",[self(),Stan]),
    ok.

