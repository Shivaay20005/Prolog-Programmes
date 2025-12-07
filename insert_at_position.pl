% insert at position CODE:
insert(I, 1, L, [I|L]).
insert(I, N, [H|T], [H|R]) :- N>1, N1 is N-1, insert(I, N1, T, R).

% USE CASE RUN:
% ?- insert(x, 2, [a,b,c], R). -> R = [a,x,b,c]
% ?- insert(99,1,[1,2,3], R). -> R = [99,1,2,3]
% ?- insert(z,3,[a,b,c], R).  -> R = [a,b,z,c]