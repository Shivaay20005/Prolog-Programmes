% CODE:
max(X, Y, X) :- X >= Y.
max(X, Y, Y) :- X < Y.

% USE CASE RUN:
% ?- max(10, 5, M).           -> M = 10
% ?- max(3, 8, M).            -> M = 8
% ?- max(7, 7, M).            -> M = 7