take([H|T],H,T).
take([H|T],X,[H|S]) :- take(T, X, S).

take_rest([H|T], H, T).
take_rest([_|T], X, R) :- take_rest(T, X, R).

choose(_, 0, []).
choose(L, N, [H|T]) :- take_rest(L, H, S), M is N - 1, choose(S, M, T).

perm([], []).
perm(L, [H|T]) :- take(L, H, R), perm(R, T).

solve([S,E,N,D], [M,O,R,E], [M,O,N,E,Y]) :- 
	choose([0,1,2,3,4,5,6,7,8,9], 8, Digits),
	perm(Digits, [S,E,N,D,M,O,R,Y]),
	0 is 1000*S + 100*E + 10*N + D +
	1000*M + 100*O + 10*R + E -
	(10000*M + 1000*O + 100*N + 10*E + Y).
