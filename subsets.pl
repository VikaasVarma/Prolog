take([H|T], H, T).
take([H|T], X, [H|S]) :- take(T, X, S).

subsets([], []).
subsets([_|T], L) :- subsets(T, L).
subsets([H|T], [H|L]) :- subsets(T, L).

