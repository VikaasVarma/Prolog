len([], 0).
len([_|T], N) :- len(T, M), N is M + 1.

split(0, R, [], R).
split(N, [H|T], [H|L], R) :- M is N - 1, split(M, T, L, R).

interleave(L, [], L).
interleave([], R, R).
interleave([H1|T1], [H2|T2], [H1|T]) :- H1 < H2, interleave(T1, [H2|T2], T).
interleave([H1|T1], [H2|T2], [H2|T]) :- H1 >= H2, interleave([H1|T1], T2, T).

mergesort([], []).
mergesort([X], [X]) :- !.
mergesort(A, B) :- len(A, N), M is N // 2, split(M, A, L, R), mergesort(L, Ls), mergesort(R, Rs), interleave(Ls, Rs, B).