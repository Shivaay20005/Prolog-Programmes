% Hill Climbing Search Algorithm in Prolog

% Define a simple problem space (example: finding maximum of a function)
% f(x) = -(x-5)^2 + 10 (maximum at x=5)

% Evaluation function (negative because we want to maximize)
evaluate(X, Value) :-
    Value is -(X-5)*(X-5) + 10.

% Generate neighbors (simple approach: x-1 and x+1)
neighbors(X, [X1, X2]) :-
    X1 is X - 1,
    X2 is X + 1.

% Hill climbing algorithm
hill_climbing(Initial, Solution) :-
    hill_climb(Initial, Initial, Solution).

hill_climb(Current, BestSoFar, Solution) :-
    evaluate(Current, CurrentValue),
    evaluate(BestSoFar, BestValue),
    (CurrentValue > BestValue ->
        NewBest = Current
    ;
        NewBest = BestSoFar
    ),
    neighbors(Current, [Neighbor1, Neighbor2]),
    evaluate(Neighbor1, Value1),
    evaluate(Neighbor2, Value2),
    (Value1 > CurrentValue ->
        hill_climb(Neighbor1, NewBest, Solution)
    ;
        (Value2 > CurrentValue ->
            hill_climb(Neighbor2, NewBest, Solution)
        ;
            Solution = NewBest  % Local maximum found
        )
    ).

% Example usage:
% ?- hill_climbing(0, Solution).
% ?- hill_climbing(10, Solution).