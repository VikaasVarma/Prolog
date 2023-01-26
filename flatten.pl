append([], L, L).
append([H|T], L, [H|R]) :- append(T, L, R).

flatten([], []).
flatten(X, [X]) :- not(is_list(X)).
flatten([H|T], L) :- flatten(H, FH), flatten(T, FT), append(FH, FT, L).
