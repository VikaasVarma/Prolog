take(H,[H|T],T).
take(X,[H|T],[H|R]) :- take(X,T,R).

take2(L,[A,B],R) :- take(A,L,R1), take(B, R1, R).

arithop(A,B,A+B) :- Ae is A, Ae \= 0, Be is B, Be \= 0.
arithop(A,B,A-B) :- Ae is A, Be is B, Ae > Be.
arithop(A,B,A*B) :- Ae is A, Ae \= 1, Be is B, Be \= 1.
arithop(A,B,A/B) :- Be is B, Be \= 1, Be \= 0, Ae is A, 0 is Ae rem Be.
arithop(A,B,A//B) :- Be is B, Be \= 0.

countdown([Soln|_], Target, Soln) :- Target is Soln.
countdown(L, Target, Soln) :- take2(L,[A,B],R), arithop(A,B,C), countdown([C|R],Target,Soln).
