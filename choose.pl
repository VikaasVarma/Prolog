take_rest([H|T], H, T).
take_rest([_|T], X, R) :- take_rest(T, X, R).

choose(_, 0, []).
choose(L, N, [H|T]) :- take_rest(L, H, S), M is N - 1, choose(S, M, T).
