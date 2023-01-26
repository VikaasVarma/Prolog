min([], Min, Min).
min([H|T], Min, Acc) :- H < Min, min(T, H, Acc).
min([H|T], Min, Acc) :- H >= Min, min(T, Min, Acc).
min([H|T], Min) :- min(T, H, Min).

take([H|T], H, T).
take([H|T], X, [H|R]) :- take(T, X, R).

min_sort([], []).
min_sort(L, [H|R]) :- min(L, H), take(L, H, S), min_sort(S, R).