safe([X,Y]) :- X = 0, X < Y.
safe([X,Y]) :- X >= Y.

range(Min, Min).
range(Min, Next) :- N2 is Min + 1, range(N2, Next).

sub([M2,C2], [M1,C1], [Mout, Cout]) :- Mout is M2 - M1, Mout >= 0, Cout is C2 - C1, Cout >= 0.
add([M1,C1], [M2,C2], [Mout, Cout]) :- Mout is M1 + M2, Cout is C1 + C2.


boat([1,0]).
boat([0,1]).
boat([1,1]).
boat([2,0]).
boat([0,2]).

step([0,0], R, [0,0], R, [0,0]).
step(L1, R1, L2, R2, B, 1) :- boat(B), sub(L1, B, L2), safe(L2), add(R1, B, R2), safe(R2).
step(L1, R1, L2, R2, B, -1) :- step(R1, L1, R2, L2, B, 1).

% journey(Path, Left, Right, Boat).
journey([], _, [0,0], _, _, _, _).
journey([B | Path], LastB, L1, R1, D, Len, Max) :- 
	Len < Max,
	step(L1, R1, L2, R2, B, D),
	B \= LastB,
	D1 is -D,
	Len1 is Len + 1,
	journey(Path, B, L2, R2, D1, Len1, Max).

journey(L, R, Path) :- range(0, Max), write(Max), write('\n'), journey(Path, [0,0], L, R, 1, 0, Max).
