% Water Jug Problem in Prolog
% Solve the problem of measuring exactly 2 gallons using a 4-gallon jug and a 3-gallon jug

% Define the capacities of the jugs
jug_capacity(1, 4).  % Jug 1 capacity: 4 gallons
jug_capacity(2, 3).  % Jug 2 capacity: 3 gallons

% Goal state: 2 gallons in jug 1, any amount in jug 2
goal_state(state(2, _)).

% Initial state: both jugs empty
initial_state(state(0, 0)).

% Possible actions:
% 1. Fill jug 1
move(state(X, Y), state(Cap1, Y)) :-
    jug_capacity(1, Cap1),
    X < Cap1.

% 2. Fill jug 2
move(state(X, Y), state(X, Cap2)) :-
    jug_capacity(2, Cap2),
    Y < Cap2.

% 3. Empty jug 1
move(state(X, Y), state(0, Y)) :-
    X > 0.

% 4. Empty jug 2
move(state(X, Y), state(X, 0)) :-
    Y > 0.

% 5. Pour from jug 1 to jug 2
move(state(X, Y), state(NewX, NewY)) :-
    X > 0, Y < Cap2,
    jug_capacity(2, Cap2),
    Transfer is min(X, Cap2 - Y),
    NewX is X - Transfer,
    NewY is Y + Transfer.

% 6. Pour from jug 2 to jug 1
move(state(X, Y), state(NewX, NewY)) :-
    Y > 0, X < Cap1,
    jug_capacity(1, Cap1),
    Transfer is min(Y, Cap1 - X),
    NewX is X + Transfer,
    NewY is Y - Transfer.

% Solve the water jug problem using BFS
solve_water_jug(Solution) :-
    initial_state(Start),
    breadth_first([[Start]], Solution).

% Breadth-first search implementation
breadth_first([[Node|Path]|_], [Node|Path]) :-
    goal_state(Node).

breadth_first([Path|Paths], Solution) :-
    extend(Path, NewPaths),
    append(Paths, NewPaths, Paths1),
    breadth_first(Paths1, Solution).

% Extend a path by one move
extend([Node|Path], NewPaths) :-
    findall([NewNode, Node|Path],
            (move(Node, NewNode), \+ member(NewNode, [Node|Path])),
            NewPaths).

% Check if an element is member of a list
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

% Append two lists
append([], L, L).
append([H|T], L, [H|R]) :-
    append(T, L, R).

% Pretty print the solution
print_solution([]).
print_solution([state(X, Y)|Rest]) :-
    write('Jug 1: '), write(X), write(' gallons, Jug 2: '), write(Y), write(' gallons'), nl,
    print_solution(Rest).

% Main predicate to solve and display the solution
solve_and_print :-
    solve_water_jug(States),
    reverse(States, Solution),
    write('Solution steps:'), nl,
    print_solution(Solution).

% Helper to reverse a list
reverse(List, Reversed) :-
    reverse(List, [], Reversed).

reverse([], Acc, Acc).
reverse([H|T], Acc, Reversed) :-
    reverse(T, [H|Acc], Reversed).

% Example usage:
% ?- solve_water_jug(Solution).
% ?- solve_and_print.
% ?- move(state(0, 0), NextState).