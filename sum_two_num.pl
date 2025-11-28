% CODE:
sum(X, Y, Result) :- Result is X + Y.

% USE CASE RUN:
% ?- sum(5, 3, R).            -> R = 8
% ?- sum(10, 25, R).          -> R = 35
% ?- sum(7, Y, 15).           -> Y = 8