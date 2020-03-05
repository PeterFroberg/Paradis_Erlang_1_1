%%%-------------------------------------------------------------------
%%% @author Peter
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. mars 2020 12:08
%%%-------------------------------------------------------------------
-module(task2).
-author("Peter").

%% API
-export([eval/2]).

eval({Operation, E1, E2}, M) when is_map(M) ->
  try
    {ok, recursive_eval1({Operation, E1, E2}, M)}
  catch
    error:badarith -> {error, variable_not_found};
    _:_ -> {error, unknown_error}
  end.




recursive_eval1(N,_M) when is_number(N) -> N;
recursive_eval1(N,M) when is_atom(N) and is_map_key(N, M) -> maps:get(N,M);
recursive_eval1(N,_M) when not is_tuple(N) -> error(badarith);
recursive_eval1({Operation, E1, E2}, M) ->

  case Operation of
    'add' ->
      recursive_eval1(E1,M) + recursive_eval1(E2,M);
    'sub' ->
      recursive_eval1(E1,M) - recursive_eval1(E2,M);
    'mul' ->
      recursive_eval1(E1,M) * recursive_eval1(E2,M);
    'div' ->
      recursive_eval1(E1,M) / recursive_eval1(E2,M)
  end.


