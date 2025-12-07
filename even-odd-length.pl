% even odd length CODE:
evenlength([]).
evenlength([_|T]) :- oddlength(T).
oddlength([_]).
oddlength([_|T]) :- evenlength(T).

% USE CASE RUN:
% ?- evenlength([a,b,c,d]).   -> true
% ?- oddlength([1,2,3]).      -> true
% ?- evenlength([x,y,z]).     -> false