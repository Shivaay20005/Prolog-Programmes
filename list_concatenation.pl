% CODE:
conc([], L, L).
conc([H|T], L2, [H|T3]) :- conc(T, L2, T3).

% USE CASE RUN:
% ?- conc([1,2], [3,4], R).   -> R = [1,2,3,4]
% ?- conc([a,b], [c], R).     -> R = [a,b,c]
% ?- conc(X, [3,4], [1,2,3,4]) -> X = [1,2]