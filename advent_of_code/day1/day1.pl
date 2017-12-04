

:-use_module(library(clpfd)).

input_sum([H|Rest],Sum):-
    input_sum_ac_carry([H|Rest],Sum,0,H).


input_sum_ac_carry([Carry|[]],Sum2,Sum,Carry):-
    Sum2 #=Sum+Carry.
input_sum_ac_carry([Last|[]],Sum,Sum,Carry):-
    dif(Last,Carry).

input_sum_ac_carry([H,H|Rest],Sum,Ac,Carry):-
    Ac2#=Ac+H,
    input_sum_ac_carry([H|Rest],Sum,Ac2,Carry).

input_sum_ac_carry([H,H2|Rest],Sum,Ac,Carry):-
    dif(H,H2),
    input_sum_ac_carry([H2|Rest],Sum,Ac,Carry).

singles_lists(A,[A]).

go(Answer):-
    read_file_to_codes('input.txt',Codes,[]),
    maplist(char_code,Chars,Codes),
    select('\n',Chars,Chars2),
    maplist(singles_lists,Chars2,Chars3),
    maplist(number_chars,Numbers,Chars3),
    input_sum(Numbers,Answer).












