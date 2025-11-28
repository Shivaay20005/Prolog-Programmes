% Best First Search Algorithm in Prolog

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

% Find all neighbors of a node
neighbors(Node, Neighbors) :-
    findall(Next, edge(Node, Next, _), Neighbors).

% Best First Search implementation
best_first_search(Start, Goal, Path) :-
    best_first([[Start]], Goal, Path).

% If the first path contains the goal, we're done
best_first([[Goal|RestPath]|_], Goal, [Goal|RestPath]).

% Otherwise, expand the first path
best_first([[Current|Path]|Rest], Goal, Solution) :-
    Current \= Goal,
    neighbors(Current, Neighbors),
    expand_neighbors(Neighbors, [Current|Path], Rest, NewPaths),
    sort_paths(NewPaths, SortedPaths),
    best_first(SortedPaths, Goal, Solution).

% Expand neighbors and create new paths
expand_neighbors([], _, Paths, Paths).
expand_neighbors([Neighbor|Rest], Path, OldPaths, NewPaths) :-
    member(Neighbor, Path),  % Skip if already in path
    expand_neighbors(Rest, Path, OldPaths, NewPaths).
expand_neighbors([Neighbor|Rest], Path, OldPaths, NewPaths) :-
    \+ member(Neighbor, Path),  % Only add if not already in path
    heuristic(Neighbor, H),
    NewPath = [Neighbor|Path],
    expand_neighbors(Rest, Path, [[H, NewPath]|OldPaths], NewPaths).

% Sort paths based on heuristic value
sort_paths(Paths, SortedPaths) :-
    sort(Paths, SortedPaths).

% Helper predicate to check membership
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

% Example usage:
% ?- best_first_search(a, h, Path).
% ?- best_first_search(a, j, Path).