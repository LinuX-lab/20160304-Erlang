-module(silnia_handler).
-behaviour(cowboy_http_handler).

-export([init/3,handle/2,terminate/3]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Inicjalizacja sesji
%%
init(_, Req, []) ->
    {ok, Req, pusteczka}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Obsłużenie zapytania
%%
handle(Req, State) ->
    {N, _} = cowboy_req:binding(liczba, Req),
    
    Ans = case silnia_serwer:silnia(N) of
	      {ok,Silnia} ->
		  io_lib:format("~p! = ~p",[N,Silnia]);
	      Err -> 
		  io_lib:format("~p! błąd ~p",[N,Err])
	  end,
    
    {ok, Req2} = cowboy_req:reply(
		   200,
		   [{<<"content-type">>, <<"text/plain">>}],
		   Ans, Req
		  ),
    {ok, Req2, State}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Zamknięcie sesji
%%
terminate(_Reason, _Req, _State) ->
    ok.
