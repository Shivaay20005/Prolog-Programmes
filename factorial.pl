% CODE:
factorial(0, 1).
factorial(N, F) :- N > 0, N1 is N-1, factorial(N1, F1), F is N * F1.

% USE CASE RUN:
% ?- factorial(5, F).         -> F = 120
% ?- factorial(4, F).         -> F = 24
% ?- factorial(N, 6).         -> N = 3
