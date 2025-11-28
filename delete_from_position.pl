% CODE:
delete(1, [H|T], T).
delete(N, [H|T], [H|R]) :- N>1, N1 is N-1, delete(N1, T, R).

% USE CASE RUN:
% ?- delete(2, [a,b,c,d], R). -> R = [a,c,d]
% ?- delete(1, [x,y,z], R).   -> R = [y,z]
% ?- delete(3, [1,2,3,4], R). -> R = [1,2,4]