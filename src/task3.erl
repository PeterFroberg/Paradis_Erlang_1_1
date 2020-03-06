%%%-------------------------------------------------------------------
%%% @author Peter
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 05. mars 2020 11:50
%%%-------------------------------------------------------------------
-module(task3).
-author("Peter").

%% API
-export([map/2, filter/2, split/2, groupby/2]).

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
  groupby(F, #{negative => [], positive => [], zero => []}, 1, L).

groupby(_F, Gresult, _Index, []) -> Gresult;
groupby(F, Gresult, Index, [H|T]) ->
  case F(H) of
    negative ->
      groupby(F, maps:update(negative, maps:get(negative, Gresult)++ [Index], Gresult), Index + 1, T);
    positive ->
      groupby(F, maps:update(positive, maps:get(positive, Gresult)++ [Index], Gresult), Index + 1, T);
    zero ->
      groupby(F, maps:update(zero, maps:get(zero, Gresult)++ [Index], Gresult), Index + 1, T)
  end.


%% Modiferad så att ISaks fråga fungerar :)
%%task3:groupby(fun (X) -> if X < 0 -> negative;
%%                     X > 0 -> positive;
%%                     true -> zero
%%                   end
%%        end, [-1, 11, 10, -4, 0]).


%%#{negative => [1, 4], positive => [2, 3], zero => [5]}
