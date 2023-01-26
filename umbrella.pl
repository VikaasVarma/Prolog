member([H|_], H).
member([_|T], X) :- member(T, X).

range(X, _, X).
range(X, Z, Y) :- X < Z, X2 is X + 1, range(X2, Z, Y).

sum([], 0).
sum([H|T], S) :- sum(T, R), S is H + R.

vec_diff([], [], []).
vec_diff([H1|T1], [H2|T2], [H3|T3]) :- abs(H1 - H2, H3), vec_diff(T1, T2, T3).

vec_mult([], [], []).
vec_mult([H1|T1], [H2|T2], [H3|T3]) :- H3 is H1 * H2, vec_mult(T1, T2, T3).

max([], Acc, Acc).
max([H|T], M, Acc) :- H > M, max(T, H, Acc).
max([H|T], M, Acc) :- H =< M, max(T, M, Acc).
max([H|T], Max) :- max(T, H, Max).

time(Before, After, Time) :- vec_diff(After, Before, Diff), vec_mult(Diff, [1,2,5,10], Mult), max(Mult, Time).

gen_list(0, []).
gen_list(N, [1 | T]) :- N > 0, M is N - 1, gen_list(M, T).
gen_list(N, [0 | T]) :- N > 0, M is N - 1, gen_list(M, T).

valid_move(Before, After, 1, Time) :- 
    gen_list(4, After), vec_diff(After, Before, Diff),
    sum(Diff, Change),
    sum(After, A), sum(Before, B),
    2 = Change, (A - B) > 0,
    time(Before, After, Time),
    Time =\= 0.

valid_move(Before, After, -1, Time) :- 
    gen_list(4, After), vec_diff(After, Before, Diff),
    sum(Diff, Change),
    sum(After, A), sum(Before, B),
    1 >= Change, (B - A) > 0,
    time(Before, After, Time),
    Time =\= 0.

solve([[1,1,1,1]], [1,1,1,1], _, _, 0).
solve([S2 | Path], S1, U1, States, T) :-
    valid_move(S1, S2, U1, Time),
    U2 is -1 * U1,
    solve(Path, S2, U2, [[U2|S2] | States], Rest),
    T is Time + Rest.

solve(Path, Time) :- solve(Path, [0,0,0,0], 1, [], Time).

iter(Path, Time) :- range(0, 100, Time), solve(Path, Time).