% CODE:
memb(X, [X|_]).
memb(X, [_|T]) :- memb(X, T).

% USE CASE RUN:
% ?- memb(3, [1,2,3,4]).      -> true
% ?- memb(5, [1,2,3,4]).      -> false
% ?- memb(X, [a,b,c]).        -> X = a ; X = b ; X = c