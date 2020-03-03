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
%%eval({Op,E1,E2}) ->
%%  case Op of
%%    add->
%%      E1+E2;
%%    mul->
%%      E1 * E2
%%  end.

eval(N) when is_number(N) -> N;
eval({Operation, E1, E2}) ->
  case Operation of
    'add' ->
      eval(E1) + eval(E2);
    'sub' ->
      eval(E1) - eval(E2);
    'mul' ->
      eval(E1) * eval(E2);
    'div' ->
      eval(E1) / eval(E2)
  end;

eval(N) when not is_number(N) -> error.