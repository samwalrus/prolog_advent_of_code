:-use_module(library(clpfd)).
:-use_module('reif.pl').

single_list(X,[X]).

myread(Sum) :-
    setup_call_cleanup(
        open('input.txt',read,In),
        (   read_lines(In, Lines),
            sumlist(Lines,Sum)
        ),
        close(In)).


read_lines(Out, Lines) :-
        read_line_to_codes(Out, Line1),
        read_lines(Line1, Out, Lines).

read_lines(end_of_file, _, []) :- !.
read_lines(Codes, Out, [Differnce|Lines]) :-
        mylist_split(Codes,Cols,=(9)),
        maplist(number_chars,NumberCols,Cols),
        max_member(Max,NumberCols),
        min_member(Min,NumberCols),
        Differnce #=Max-Min,
        read_line_to_codes(Out, Line2),
        read_lines(Line2, Out, Lines).


mylist_split([],[],_).
mylist_split([X0|Xs],     [Q|Bss],P_2) :-
   mylist_prev_split_(Xs,X0,Cs,Bss, P_2),
   Cs=[H|T],
   if_(call(P_2,H),Q=T,Q=Cs).

mylist_prev_split_([],     X, [X],[],_).
mylist_prev_split_([X1|Xs],X0,[X0|Cs],Bss,P_2) :-
   if_(call(P_2,X1),
       (Cs = [],  Cs0=[_|T],Bss = [T|Bss0]),
       (Cs = Cs0, Bss = Bss0)),
   mylist_prev_split_(Xs,X1,Cs0,Bss0,P_2).


