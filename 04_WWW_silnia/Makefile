PROJECT = silnia
PROJECT_DESCRIPTION = Aplikacja do liczenia silni (WEB)
PROJECT_VERSION = 2.0.0

DEPS = cowboy

dep_cowboy = git https://github.com/ninenines/cowboy 1.0.4

include erlang.mk


observer:
	erl -sname observer -setcookie LwB -run observer
