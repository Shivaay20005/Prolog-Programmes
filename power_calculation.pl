% CODE:
power(_, 0, 1).
power(Num, Pow, Ans) :- Pow>0, Pow1 is Pow-1,
power(Num, Pow1, Ans1), Ans is Num * Ans1.

% USE CASE RUN:
% ?- power(2, 3, Ans).        -> Ans = 8
% ?- power(5, 2, Ans).        -> Ans = 25
% ?- power(2, Pow, 16).       -> Pow = 4