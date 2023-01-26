append([], L, L).
append([H|T], L, [H|R]) :- append(T, L, R).

split(_, [], [], []).
split(P, [H|T], [H|L], R) :- H < P, split(P, T, L, R).
split(P, [H|T], L, [H|R]) :- H >= P, split(P, T, L, R).

quicksort([], []).
quicksort([H|T], S) :- split(H, T, L, R), quicksort(L, SL), quicksort(R, SR), append(SL, [H|SR], S).

dquicksort([], B-B).
dquicksort([H|T], S-B) :- split(H, T, L, R), dquicksort(L, S-[H|SR]), dquicksort(R, SR-B).
