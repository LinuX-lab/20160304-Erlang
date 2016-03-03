-module(silnia03).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Funkcje użytkowe
-export([start_serwer/0,policz/2,stop_serwer/1]).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Musimy wyeksportować funkcje użyte w wywołaniach spawn_*
-export([serwer/0]).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Zapętlona funkcja implementująca serwer
serwer() ->
    io:format("Serwer ~p czeka na polecenie~n",[self()]),

    %% Czekamy na komunikat z zewnątrz. Po otrzymaniu jest robione
    %% coś na kształc "case" z C
    receive
	koniec ->
	    io:format("Serwer ~p kończy działanie~n",[self()]),
	    ok; %% Nie ma wywołania rekurencyjnego, koniec procesu
	
	{silnia,N,Pid} when is_number(N),
			    is_pid(Pid),
			    N>=0 ->
	    io:format("Serwer ~p liczy ~p! dla ~p~n",[self(),N,Pid]),

	    %% Liczymy wynik
	    Odp = silnia02:silnia(N),

	    %% Odsyłamy go pytającemu
	    Pid ! Odp,
	    io:format("Serwer ~p odesłał ~p! wynik~n",[self(),Pid]),

	    %% A serwer się zapętla.
	    serwer();

	{silnia,N,Pid} when is_pid(Pid)-> 
	    io:format("Serwer ~p nie może policzyć ~p! dla ~p~n",[self(),N,Pid]),

	    %% A tu błąd
	    Pid ! {error,badarg},

	    %% Błąd nie powoduje przerwania pracy serwera
	    serwer();

	X ->
	    %% Nie rozpoznane komunikaty - lepiej je "zjadać" niż zostawiać w kolejce
	    io:format("Serwer ~p otrzymał nieznane polecenie ~p~n",[self(),X]),

	    %% Błąd nie powoduje przerwania pracy serwera
	    serwer()
    end.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Wysłanie zadania obliczenia do serwera
policz(Serwer,N) when is_pid(Serwer) ->
          
    io:format("Proces ~p zleca policzenie ~p! serwerowi ~p~n",[self(),N,Serwer]),

    %% Wysłanie komunikatu do serwera
    Serwer ! {silnia,N,self()},

    %% Oczekiwanie na wynik
    receive
	Wynik ->
	    %% Odebrano wynik, zwróć go
	    io:format("Proces ~p otrzymał wynik ~p~n",[self(),Wynik]),
	    Wynik

    after 1000 ->
	    %% Nie otrzymano wyniku w czasie 1s, zgłoś błąd
	    io:format("Proces ~p nie otrzymał odpowiedzi~n",[self()]),

	    {error,timeout}
    end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Uruchomienie serwera
start_serwer() ->
    %% Uruchomienie funkcji w nowym procesie (spawn_*), z tym że NASZ proces zostanie
    %% poinformowany o zakończeniu nowego z dowolnej przyczyny (*_monitor)
    {Pid,_Ref} = spawn_monitor(?MODULE,serwer,[]),
    io:format("Proces ~p uruchomił serwer ~p~n",[self(),Pid]),
    Pid.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Zatrzymanie serwera
stop_serwer(Pid) when is_pid(Pid) ->
    io:format("Proces ~p wysłał do serwera ~p polecenie stopu~n",[self(),Pid]),

    %% Wysyłamy polecenie zatrzymania
    Pid ! koniec,

    %% Czekamy na potwierdzenie (generowane przez samą VM ze względu
    %% na użycie spawn_monitor do uruchomienia procesu potomnego)
    receive
	{'DOWN',_Ref,process,Pid,Reason} ->
	    %% Potwierdzenie od VM
	    io:format("Proces ~p otrzymał potwierdzenie zatrzymania ~p (~p)~n",[self(),Pid,Reason]),
	    ok
		
    after 1000 ->
	    %% Brak potwierdzenia w ciągu 1s
	    io:format("Proces ~p nie dostał potwierdzenia zatrzymania ~p~n",[self(),Pid]),
	    {error,timeout}
    end.
