% CODE:
maxlist([X], X).
maxlist([H|T], M) :- maxlist(T, M1), (H > M1 -> M = H; M = M1).

% USE CASE RUN:
% ?- maxlist([3,1,4,2], M).   -> M = 4
% ?- maxlist([10,5,8], M).    -> M = 10
% ?- maxlist([7,2,9,1], M).   -> M = 9