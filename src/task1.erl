%%%-------------------------------------------------------------------
%%% @author Peter
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 03. mars 2020 14:59
%%%-------------------------------------------------------------------
-module(task1).
-author("Peter").

-export([eval/1]).

eval({Operation, E1, E2}) ->
  try
    {ok, recursive_eval1({Operation, E1, E2})}
  catch
    _:_ -> error
  end.


recursive_eval1(N) when is_number(N) -> N;
recursive_eval1(N) when not is_number(N) and not is_tuple(N) -> error(badarith);
recursive_eval1({Operation, E1, E2}) ->

  case Operation of
    'add' ->
      recursive_eval1(E1) + recursive_eval1(E2);
    'sub' ->
      recursive_eval1(E1) - recursive_eval1(E2);
    'mul' ->
      recursive_eval1(E1) * recursive_eval1(E2);
    'div' ->
      recursive_eval1(E1) / recursive_eval1(E2)
  end.
