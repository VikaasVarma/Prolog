take([H|T],H,T).
take([H|T],X,[H|R]) :- take(T,X,R).

perm([],[]).
perm(L,[H|T]) :- take(L, H, R), perm(R, T).

diff(L) :- diff_set(L, [1,2,3,4,5,6,7,8,9]).
diff_set([], _).
diff_set([H|T], S) :- var(H), diff_set(T, S).
diff_set([H|T], S) :- ground(H), take(S, H, R), diff_set(T, R).

gen_digits(L) :- perm([1,2,3,4,5,6,7,8,9],L).

get_cols([],[],[]).
get_cols([[H|T1]|T], [H|Hs], [T1|Ts]) :- get_cols(T, Hs, Ts).


test_row(A) :- diff(A).

test_cols([[]|_]).
test_cols(Puzzle) :- get_cols(Puzzle, Heads, Tails), diff(Heads), test_cols(Tails).

test_blocks([A1,B1,C1,D1,E1,F1,G1,H1,I1],
	    [A2,B2,C2,D2,E2,F2,G2,H2,I2],
	    [A3,B3,C3,D3,E3,F3,G3,H3,I3]) :- diff([A1,B1,C1,A2,B2,C2,A3,B3,C3]),
					     diff([D1,E1,F1,D2,E2,F2,D3,E3,F3]),
					     diff([G1,H1,I1,G2,H2,I2,G3,H3,I3]).


solve([A,B,C,D,E,F,G,H,I]) :- gen_digits(A),
			      test_cols([A,B,C,D,E,F,G,H,I]),
			      gen_digits(B),
			      test_cols([A,B,C,D,E,F,G,H,I]),
			      gen_digits(C),
			      test_cols([A,B,C,D,E,F,G,H,I]),
			      test_blocks(A,B,C),
			      gen_digits(D),
			      test_cols([A,B,C,D,E,F,G,H,I]),
			      gen_digits(E),
			      test_cols([A,B,C,D,E,F,G,H,I]),
			      gen_digits(F),
			      test_cols([A,B,C,D,E,F,G,H,I]),
			      test_blocks(D,E,F),
			      gen_digits(G),
			      test_cols([A,B,C,D,E,F,G,H,I]),
			      gen_digits(H),
			      test_cols([A,B,C,D,E,F,G,H,I]),
			      gen_digits(I),
			      test_cols([A,B,C,D,E,F,G,H,I]),
			      test_blocks(G,H,I).


:- A = [5,3,_,_,7,_,_,_,_],
   B = [6,_,_,1,9,5,_,_,_],
   C = [_,9,8,_,_,_,_,6,_],
   D = [8,_,_,_,6,_,_,_,3],
   E = [4,_,_,8,_,3,_,_,1],
   F = [7,_,_,_,2,_,_,_,6],
   G = [_,6,_,_,_,_,2,8,_],
   H = [_,_,_,4,1,9,_,_,5],
   I = [_,_,_,_,8,_,_,7,9],
   Puzzle = [A,B,C,D,E,F,G,H,I],
   solve(Puzzle),
   print(Puzzle).
