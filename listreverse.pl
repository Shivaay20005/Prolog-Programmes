% CODE:
reverse([], []).
reverse([H|T], R) :- reverse(T, R1), conc(R1, [H], R).

% USE CASE RUN:
% ?- reverse([1,2,3], R).     -> R = [3,2,1]
% ?- reverse([a,b,c], R).     -> R = [c,b,a]
% ?- reverse(X, [3,2,1]).     -> X = [1,2,3]