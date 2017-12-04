

:-use_module(library(clpfd)).

singles_lists(A,[A]).

go(Answer):-
    read_file_to_codes('input.txt',Codes,[]),
    maplist(char_code,Chars,Codes),
    select('\n',Chars,Chars2),
    maplist(singles_lists,Chars2,Chars3),
    maplist(number_chars,Numbers,Chars3),
    input_sum(Numbers,Answer).

go2(Answer):-
    read_file_to_codes('input2.txt',Codes,[]),
    maplist(char_code,Chars,Codes),
    select('\n',Chars,Chars2),
    maplist(singles_lists,Chars2,Chars3),
    maplist(number_chars,Numbers,Chars3),
    input_sumB(Numbers,Answer).



%PartA
input_sum([H|Rest],Sum):-
    input_sum_ac_carry([H|Rest],Sum,0,H).


input_sum_ac_carry([Carry|[]],Sum,Ac,Carry):-
    Sum #=Ac+Carry.
input_sum_ac_carry([Last|[]],Sum,Sum,Carry):-
    dif(Last,Carry).

input_sum_ac_carry([H,H|Rest],Sum,Ac,Carry):-
    Ac2#=Ac+H,
    input_sum_ac_carry([H|Rest],Sum,Ac2,Carry).

input_sum_ac_carry([H,H2|Rest],Sum,Ac,Carry):-
    dif(H,H2),
    input_sum_ac_carry([H2|Rest],Sum,Ac,Carry).


%PartB


input_sumB(Input,Sum):-
    length(Input,L),
    L2 #= L//2,
    input_sum_ac_counter_forward(Input,Sum,0,1,Input-L2).

input_sum_ac_counter_forward(Input,Sum,Ac,_Counter,Whole-L2):-
    Input = [Last|[]],
    Index #=L2-1,
    length(FrontList,Index),
    append(FrontList,[Last|_BackList],Whole),
    Sum #=Ac +Last.

input_sum_ac_counter_forward(Input,Sum,Sum,_Counter,Whole-L2):-
     Input = [Last|[]],
     Index #=L2-1,
     length(FrontList,Index),
     append(FrontList,[LastCheck|_BackList],Whole),
     dif(Last,LastCheck).


input_sum_ac_counter_forward(Input,Sum,Ac0,Counter,Whole-L2):-
    Input = [H|T],
    L2 #>= Counter,
    Counter2#=Counter+1,
    Index #=Counter+L2-1,
    length(FrontList,Index),
    append(FrontList,[Item|_BackList],Whole),
    H=Item,
    Ac #=Ac0 + Item,
    input_sum_ac_counter_forward(T,Sum,Ac,Counter2,Whole-L2).

input_sum_ac_counter_forward(Input,Sum,Ac,Counter,Whole-L2):-
    Input = [H|T],
    L2 #>= Counter,
    Counter2#=Counter+1,
    Index #=Counter+L2-1,
    length(FrontList,Index),
    append(FrontList,[Item|_BackList],Whole),
    dif(H,Item),
    input_sum_ac_counter_forward(T,Sum,Ac,Counter2,Whole-L2).


input_sum_ac_counter_forward(Input,Sum,Ac0,Counter,Whole-L2):-
    Input = [H|T],
    L2 #< Counter,
    Counter2#=Counter+1,
    Index #=Counter-L2-1,
    length(FrontList,Index),
    append(FrontList,[Item|_BackList],Whole),
    H=Item,
    Ac #=Ac0+Item,
    input_sum_ac_counter_forward(T,Sum,Ac,Counter2,Whole-L2).

input_sum_ac_counter_forward(Input,Sum,Ac,Counter,Whole-L2):-
    Input = [H|T],
    L2 #< Counter,
    Counter2#=Counter+1,
    Index #=Counter-L2-1,
    length(FrontList,Index),
    append(FrontList,[Item|_BackList],Whole),
    dif(H,Item),
    input_sum_ac_counter_forward(T,Sum,Ac,Counter2,Whole-L2).










