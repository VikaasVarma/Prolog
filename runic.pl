clockwise(up, right).
clockwise(right, down).
clockwise(down, left).
clockwise(left, up).


len([], 0).
len([_ | T], N) :- len(T, N1), N is N1 + 1.

range(Min, Min).
range(Min, Next) :- N2 is Min + 1, range(N2, Next).

excludes(_, []) :- !.
excludes(X, [Y | T]) :- X \= Y, excludes(X, T).

remove( _, [], []).
remove( R, [R|T], T2) :- remove( R, T, T2).
remove( R, [H|T], [H|T2]) :- H \= R, remove( R, T, T2).

compress([], []).
compress([M, M, M | T], [r, M | T1]) :- compress(T, T1).
compress([H | T1], [H | T2]) :- compress(T1, T2).

extra([]).
extra([c]).
extra([M | T]) :- M \= c, !, extra(T).
extra([_, M2 | T]) :- M2 \= c, extra(T).


add([X, Y], [X1, Y1], [X2, Y2]) :- X2 is X + X1, Y2 is Y + Y1.
rotate([X, Y], [X1, Y1]) :- X1 is -Y, Y1 is X.

face(up, D, D).
face(left, D, D1) :- rotate(D, D1).
face(down, D, D2) :- rotate(D, D1), rotate(D1, D2).
face(right, D, D3) :- rotate(D, D1), rotate(D1, D2), rotate(D2, D3).


disp(a, [0, 1]).
disp(c, [0, 0]).
disp(n, [1, 2]).

dir(a, D, D).
dir(c, D, D1) :- clockwise(D, D1).
dir(n, D, D1) :- clockwise(D, D1).

no_hit_triangle(_, _, c, _).
no_hit_triangle(P, D, a, T) :- face(D, [0, 1], Disp), add(P, Disp, P1), excludes(P1, T).
no_hit_triangle(P, D, n, T) :-
    face(D, [0, 1], Disp1), add(P , Disp1, P1), excludes(P1, T),
                            add(P1, Disp1, P2), excludes(P2, T),
    face(D, [1, 0], Disp2), add(P2, Disp2, P3), excludes(P3, T).

filter(_, _, c, R, R).
filter(P, D, a, R, R1) :- face(D, [0, 1], Disp), add(P, Disp, P1), remove(P1, R, R1).
filter(P, D, n, R, R1) :-
    face(D, [0, 1], Disp1), add(P , Disp1, P1), remove(P1, R, R2),
                            add(P1, Disp1, P2), remove(P2, R2, R3),
    face(D, [1, 0], Disp2), add(P2, Disp2, P3), remove(P3, R3, R1).

hit_rhombuses(_, _, _, []).
hit_rhombuses(P, D, [M | Path], R) :-
    filter(P, D, M, R, R1),
    move(P, D, M, P1, D1),
    hit_rhombuses(P1, D1, Path, R1).

move(P1, D1, M, P2, D2) :- disp(M, Disp), face(D1, Disp, Disp1), add(P1, Disp1, P2), dir(M, D1, D2).

path(S, S, _, _, _, [], 0).
path(S, E, D, T, R, [M | Path], Depth) :-
    Depth > 0, Depth1 is Depth - 1,
    move(S, D, M, S1, D1),
    no_hit_triangle(S, D, M, T),
    path(S1, E, D1, T, R, Path, Depth1).

path(S, E, T, R, Path) :- 
    range(0, Max), path(S, E, up, T, R, P, Max),
    hit_rhombuses(S, up, P, R), compress(P, Path), extra(Path).
