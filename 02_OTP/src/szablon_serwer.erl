-module(szablon_serwer).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Wypełnia listę callbacków do zaimplementowania.
%%
-behaviour(gen_server).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Eksportowane funkcje użytkownika
%%

-export([start/1]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Eksportowane funkcje GEN_SERVER.
%%
-export([
	 init/1,
	 handle_call/3,
	 handle_cast/2,
	 handle_info/2,
	 terminate/2,
	 code_change/3
	]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Uruchomienie serwera
%%

start(link) ->  gen_server:start_link({local,'Szablon serwer'},?MODULE,[],[]);
start(_) ->     gen_server:start({local,'Szablon serwer'},?MODULE,[],[]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Callback wywoływany przez system przy uruchomieniu serwera
%% w kontekście procesu nowego serwera.
%%
init(Arg) ->
    process_flag(trap_exit, true),
    io:format("GS:~p init(~p).~n",[self(),Arg]),
    {ok,pusteczka}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Callback wywoływany w odpowiedzi na gen_server:call(s,a)
%%
handle_call(Arg,From,State) ->
    io:format("GS:~p handle_call(~p,~p,~p).~n",[self(),Arg,From,State]),
    {reply,Arg,State}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Callback wywoływany w odpowiedzi na gen_server:cast(s,a)
%%
handle_cast(Arg,State) ->
    io:format("GS:~p handle_cast(~p,~p).~n",[self(),Arg,State]),
    {noreply,State}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Callback wywoływany w odpowiedzi na nieznane komunikaty
%%
handle_info(Arg,State) ->
    io:format("GS:~p handle_info(~p,~p).~n",[self(),Arg,State]),
    {noreply,State}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Callback wywoływany przy zatrzymaniu serwera
%%
terminate(Reason,State) ->
    io:format("GS:~p terminate(~p,~p).~n",[self(),Reason,State]),
    ok.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Callback wywoływany przy upgrade/downgrade
%%
code_change(OldVsn, State, Extra) ->
    io:format("GS:~p code_change(~p,~p,~p).~n",[self(),OldVsn,State,Extra]),
    {ok,State}.
