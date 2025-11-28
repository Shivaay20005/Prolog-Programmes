% A* Search Algorithm in Prolog

% Define a simple graph with edges and heuristic values
% Edges: edge(From, To, Cost)
edge(a, b, 4).
edge(a, c, 2).
edge(b, d, 3).
edge(b, e, 1).
edge(c, f, 5).
edge(c, g, 3).
edge(d, h, 2).
edge(e, i, 4).
edge(f, j, 1).
edge(g, k, 2).

% Heuristic values (estimated cost to goal node 'h')
heuristic(a, 8).
heuristic(b, 5).
heuristic(c, 7).
heuristic(d, 2).
heuristic(e, 6).
heuristic(f, 4).
heuristic(g, 3).
heuristic(h, 0).
heuristic(i, 8).
heuristic(j, 1).
heuristic(k, 2).

% A* Search implementation
a_star_search(Start, Goal, Path, Cost) :-
    a_star([[0, Start, []]], Goal, Path, Cost).

% If the first path reaches the goal, we're done
a_star([[Cost, Goal, Path]|_], Goal, FinalPath, FinalCost) :-
    reverse([Goal|Path], FinalPath),
    FinalCost is Cost.

% Otherwise, expand the first path
a_star([[CurrentCost, Current, Visited]|Rest], Goal, SolutionPath, SolutionCost) :-
    Current \= Goal,
    findall(
        [NewTotalCost, Next, [Current|Visited]],
        (
            edge(Current, Next, EdgeCost),
            \+ member(Next, Visited),
            heuristic(Next, H),
            NewPathCost is CurrentCost + EdgeCost,
            NewTotalCost is NewPathCost + H
        ),
        NewPaths
    ),
    append(Rest, NewPaths, AllPaths),
    sort(AllPaths, SortedPaths),
    a_star(SortedPaths, Goal, SolutionPath, SolutionCost).

% Helper predicate to reverse a list
reverse(List, Reversed) :-
    reverse(List, [], Reversed).

reverse([], Acc, Acc).
reverse([H|T], Acc, Reversed) :-
    reverse(T, [H|Acc], Reversed).

% Helper predicate to check membership
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

% Helper predicate to append lists
append([], L, L).
append([H|T], L, [H|R]) :-
    append(T, L, R).

% Example usage:
% ?- a_star_search(a, h, Path, Cost).
% ?- a_star_search(a, j, Path, Cost).