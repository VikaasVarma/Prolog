append([], L, L).
append([H|T], L, [H|R]) :- append(T, L, R).


preorder(nil, []).
preorder(L-N+R, ValueList) :- preorder(L, L1), preorder(R, R1), append([N|L1], R1, ValueList).

preorderdl(nil, A-A).
preorderdl(L-N+R, [N|L1]-A) :- preorderdl(L, L1-R1), preorderdl(R, R1-A).