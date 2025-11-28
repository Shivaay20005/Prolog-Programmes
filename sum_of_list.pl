% CODE:
sumlist([], 0).
sumlist([H|T], S) :- sumlist(T, S1), S is H + S1.

% USE CASE RUN:
% ?- sumlist([1,2,3,4], S).   -> S = 10
% ?- sumlist([5,10,15], S).   -> S = 30
% ?- sumlist([2,4,6], S).     -> S = 12