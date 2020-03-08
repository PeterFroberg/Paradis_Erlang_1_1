%%%-------------------------------------------------------------------
%%% @author Peter Froberg
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 03. mars 2020 14:59
%%%-------------------------------------------------------------------
-module(task1).
-author("Peter Froberg").

-export([eval/1, eval/2,map/2, filter/2, split/2, groupby/2]).

eval({Operation, E1, E2}) ->
  try
    {ok, recursive_eval({Operation, E1, E2})}
  catch
    _:_ -> error
  end.


recursive_eval(N) when is_number(N) -> N;
recursive_eval(N) when not is_number(N) and not is_tuple(N) -> error(badarith);
recursive_eval({Operation, E1, E2}) ->

  case Operation of
    'add' ->
      recursive_eval(E1) + recursive_eval(E2);
    'sub' ->
      recursive_eval(E1) - recursive_eval(E2);
    'mul' ->
      recursive_eval(E1) * recursive_eval(E2);
    'div' ->
      recursive_eval(E1) / recursive_eval(E2)
  end.

eval({Operation, E1, E2}, M) when is_map(M) ->
  try
    {ok, recursive_eval({Operation, E1, E2}, M)}
  catch
    error:badarith -> {error, variable_not_found};
    _:_ -> {error, unknown_error}
  end.




recursive_eval(N,_M) when is_number(N) -> N;
recursive_eval(N,M) when is_atom(N) and is_map_key(N, M) -> maps:get(N,M);
recursive_eval(N,_M) when not is_tuple(N) -> error(badarith);
recursive_eval({Operation, E1, E2}, M) ->

  case Operation of
    'add' ->
      recursive_eval(E1,M) + recursive_eval(E2,M);
    'sub' ->
      recursive_eval(E1,M) - recursive_eval(E2,M);
    'mul' ->
      recursive_eval(E1,M) * recursive_eval(E2,M);
    'div' ->
      recursive_eval(E1,M) / recursive_eval(E2,M)
  end.


map(F, L) ->
  map(F, [], L ).

map(_F, Result, []) -> Result;
map(F, Result, [H|T]) ->
  map(F, Result++ [F(H)], T).


filter(F, L) ->
  filter(F, [], L).

filter(_F, Fresult, []) -> Fresult;
filter(F, Fresult, [H|T])  ->
  case F(H) of
    true ->
      filter(F, Fresult++ [H], T);
    false ->
      filter(F, Fresult, T)
  end.

split(F,L) ->
  split(F, {[],[]}, L).

split(_F, Sresult, []) -> Sresult;
split(F, Sresult, [H|T]) ->
  {X,_} = Sresult,
  {_,Y} = Sresult,
  case F(H) of
    true ->
      split(F, {X++ [H],Y}, T);
    false ->
      split(F, {X, Y++ [H]}, T)
  end.


groupby(F,L) ->
  groupby(F, #{}, 1, L).

groupby(_F, Gresult, _Index, []) -> Gresult;
groupby(F, Gresult, Index, [H|T]) ->
  groupby(F, maps:put(F(H), maps:get(F(H), Gresult,[])++ [Index], Gresult), Index + 1, T).
