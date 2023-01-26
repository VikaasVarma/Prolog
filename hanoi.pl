member([H|_], H).
member([_|T], X) :- member(T, X).


valid_moves([B, M, S1], [B, M, S2]) :- member([1,2,3], S2), S1 =\= S2.
valid_moves([B, M1, S], [B, M2, S]) :- member([1,2,3], M2), M1 =\= M2, S =\= M1, S =\= M2.
valid_moves([B1, M, S], [B2, M, S]) :- member([1,2,3], B2), B1 =\= B2, M =\= B1, M =\= B2, S =\= B1, S =\= B2.

step(S1, S2, States) :- valid_moves(S1, S2), \+member(States, S2).

solve([], [3,3,3], _).
solve([S2 | Path], S1, States) :- step(S1, S2, States), solve(Path, S2, [S1 | States]).
solve(Path) :- solve(Path, [1,1,1], []).