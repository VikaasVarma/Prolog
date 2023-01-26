next(a,b).
next(b,c).
next(c,d).
next(d,e).
next(e,f).
next(f,g).
next(g,h).
next(h,i).
next(i,j).
next(j,k).
next(k,l).
next(l,m).
next(m,n).
next(n,o).
next(o,p).
next(p,q).
next(q,r).
next(r,s).
next(s,t).
next(t,u).
next(u,v).
next(v,w).
next(w,x).
next(x,y).
next(y,z).
next(z,a).

%- nextn(N, A, B) succeeds if A and B are N-steps away from each other.
nextn(0, A, A).
nextn(N, A, B) :- N > 0, N1 is N - 1, next(A, C), nextn(N1, C, B).


list([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]).

scan(C, L, [C|L]).
scan(C, T, [_|L]) :- scan(C, T, L).

charAt(0, C1, [C1|_]).
charAt(N, C1, [_|T]) :- N > 0, N1 is N - 1, charAt(N1, C1, T).

nextn2(N, A, B) :- list(L), scan(A, R, L), append(R, L, L2), charAt((N - 1) rem 26, B, L2).


convert(_, [], []).
convert(N, [H1|T1], [H2|T2]) :- nextn2(N, H1, H2), convert(N, T1, T2).

range(L, _, L).
range(L, H, N) :- L2 is L + 1, L2 < H, range(L2, H, N).

ceaser(N, A, B) :- range(0, 26, N), convert(N, A, C), B = C.

