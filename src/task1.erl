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
eval(X) ->
  case X of
    {add,A,B}->
      A+B;
    {mul,A,B}->
      A * B
  end.