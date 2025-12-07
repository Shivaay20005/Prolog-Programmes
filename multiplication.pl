% multiplication CODE:
multi(N1, N2, R) :- R is N1 * N2.

% USE CASE RUN:
% ?- multi(4, 5, R).          -> R = 20
% ?- multi(7, 3, R).          -> R = 21
% ?- multi(6, Y, 30).         -> Y = 5