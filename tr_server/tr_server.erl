%%%---------------------------------------------------------------------
%%% @author Arjan van Eersel <arjanvaneersel@gmail.com>
%%% @copyright 2020, Arjan van Eersel
%%% @doc RPC over TCP server. This module defines a server process that
%%%     listens for incoming TCP connections and allows the user to
%%%     execute RPC commands via the TCP stream.
%%% end
%%%---------------------------------------------------------------------

-module(tr_server).
-behaviour(gen_server).

%% API
-export([]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
    terminate/2, code_change/3]).

-define(SERVER, ?MODULE).
-define(DEFAULT_PORT, 1055).

-record(state, {lsock, request_count = 0}).

%%%=====================================================================
%%% API
%%%=====================================================================

%%----------------------------------------------------------------------
%% @doc Starts the server.
%%
%% @spec start_link(Port::integer()) -> {ok, Pid}
%% where
%%  Pid = pid()
%% @end
%%----------------------------------------------------------------------
start_link(Port) ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, {PORT}, []).

%% @spec start_link() -> {ok, Pid}
%% @doc Calls ˇstart_link(Port)ˇ using the default port.
start_link() ->
    gen_server:start_link(?DEFAULT_PORT).

%%----------------------------------------------------------------------
%% @doc Patches the number of requests made to this server.
%%
%% @spec get_count() -> {ok, Count}
%% where
%%  Count = integer()
%% @end
%%----------------------------------------------------------------------
gen_count() ->
    gen_server:call(?SERVER, get_count).

%%----------------------------------------------------------------------
%% @doc Stops the server.
%%
%% @spec stop() -> ok
%% @end
%%----------------------------------------------------------------------
stop() ->
    gen_server:cast(?SERVER, stop).