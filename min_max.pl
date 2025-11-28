% Min-Max Search Algorithm in Prolog
% Implementation for a simple game tree

% Define a simple game tree structure
% node(Value, Children)
% Leaf nodes have no children

% Sample game tree
game_tree(node(0, [
    node(0, [
        node(3, []),
        node(12, []),
        node(8, [])
    ]),
    node(0, [
        node(2, []),
        node(4, []),
        node(6, [])
    ]),
    node(0, [
        node(14, []),
        node(5, []),
        node(2, [])
    ])
])).

% Minimax algorithm implementation
% minimax(Node, Depth, MaximizingPlayer, Score)

% Base case: leaf node
minimax(node(Value, []), _, _, Value).

% Recursive case: internal node
minimax(node(_, Children), Depth, true, MaxScore) :-
    Depth > 0,
    NewDepth is Depth - 1,
    findall(Score, (
        member(Child, Children),
        minimax(Child, NewDepth, false, Score)
    ), Scores),
    max_list(Scores, MaxScore).

minimax(node(_, Children), Depth, false, MinScore) :-
    Depth > 0,
    NewDepth is Depth - 1,
    findall(Score, (
        member(Child, Children),
        minimax(Child, NewDepth, true, Score)
    ), Scores),
    min_list(Scores, MinScore).

% Helper predicates for finding maximum and minimum in a list
max_list([X], X).
max_list([H|T], Max) :-
    max_list(T, TailMax),
    (H > TailMax -> Max = H ; Max = TailMax).

min_list([X], X).
min_list([H|T], Min) :-
    min_list(T, TailMin),
    (H < TailMin -> Min = H ; Min = TailMin).

% Helper predicate for membership
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

% Main predicate to run minimax on our sample game tree
solve_minimax(BestScore) :-
    game_tree(Tree),
    minimax(Tree, 3, true, BestScore).

% Example usage:
% ?- solve_minimax(Score).
% ?- minimax(node(0, [node(3,[]), node(5,[]), node(2,[])]), 1, true, Score).