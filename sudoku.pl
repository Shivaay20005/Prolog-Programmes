% Sudoku Solver in Prolog using Constraint Satisfaction

% Define the Sudoku puzzle (0 represents empty cells)
% Sample 9x9 Sudoku puzzle
sudoku_puzzle([
    [5, 3, 0, 0, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9]
]).

% Solve the Sudoku puzzle
solve_sudoku(Puzzle, Solution) :-
    flatten(Puzzle, Flat),
    domain(Flat, 1, 9),
    constraints(Puzzle),
    labeling([], Flat),
    Puzzle = Solution.

% Flatten a 2D list to 1D
flatten([], []).
flatten([H|T], Flat) :-
    flatten(T, Flat1),
    append(H, Flat1, Flat).

% Domain constraint: all variables must be between Min and Max
domain([], _, _).
domain([H|T], Min, Max) :-
    H in Min..Max,
    domain(T, Min, Max).

% Apply all Sudoku constraints
constraints(Puzzle) :-
    % Row constraints
    rows_different(Puzzle),
    % Column constraints
    transpose(Puzzle, Transposed),
    rows_different(Transposed),
    % 3x3 box constraints
    boxes_different(Puzzle).

% Ensure all elements in each row are different
rows_different([]).
rows_different([Row|Rows]) :-
    all_different(Row),
    rows_different(Rows).

% Ensure all elements in a list are different
all_different([]).
all_different([H|T]) :-
    diff(H, T),
    all_different(T).

diff(_, []).
diff(X, [Y|T]) :-
    X #\= Y,
    diff(X, T).

% Transpose a matrix
transpose([], []).
transpose([[]|_], []).
transpose(Matrix, [Row|Rows]) :-
    first_column(Matrix, Row, RestMatrix),
    transpose(RestMatrix, Rows).

first_column([], [], []).
first_column([[H|T]|Rows], [H|Col], [T|RestRows]) :-
    first_column(Rows, Col, RestRows).

% Ensure all 3x3 boxes have different elements
boxes_different(Puzzle) :-
    boxes_rows(Puzzle, 3, Boxes),
    maplist(all_different, Boxes).

boxes_rows([], _, []).
boxes_rows([_, _, _|Rows], 0, Boxes) :-
    boxes_rows(Rows, 3, Boxes).
boxes_rows([R1, R2, R3|Rows], N, Boxes) :-
    N > 0,
    box_row(R1, R2, R3, BoxRow, R1Rest, R2Rest, R3Rest),
    boxes_rows([R1Rest, R2Rest, R3Rest|Rows], N-1, RestBoxes),
    append(BoxRow, RestBoxes, Boxes).

box_row([], [], [], [], [], [], []).
box_row([A,B,C|Rest1], [D,E,F|Rest2], [G,H,I|Rest3],
        [[A,B,C,D,E,F,G,H,I]|Boxes], Rest1, Rest2, Rest3) :-
    box_row(Rest1, Rest2, Rest3, Boxes, _, _, _).

% Labeling predicate to find concrete values
labeling(_, []).
labeling(Opts, [V|Vars]) :-
    indomain(V),
    labeling(Opts, Vars).

indomain(V) :-
    fd_min(V, Min),
    fd_max(V, Max),
    between(Min, Max, V).

% Print the Sudoku grid in a readable format
print_grid([]).
print_grid([Row|Rows]) :-
    print_row(Row),
    print_grid(Rows).

print_row([]) :- nl.
print_row([H|T]) :-
    (H = 0 -> write('_') ; write(H)),
    write(' '),
    print_row(T).

% Main predicate to solve and display a Sudoku puzzle
solve_and_print :-
    sudoku_puzzle(Puzzle),
    write('Original Puzzle:'), nl,
    print_grid(Puzzle),
    solve_sudoku(Puzzle, Solution),
    write('Solved Puzzle:'), nl,
    print_grid(Solution).

% Note: This implementation uses CLP(FD) constraints which may not be available
% in all Prolog implementations. For systems without CLP(FD), here's a simpler version:

% Alternative implementation without CLP(FD)
% This is a backtracking solution

% Check if a number can be placed in a cell
valid_move(Grid, Row, Col, Number) :-
    % Check row
    \+ member(Number, Grid, Row),
    % Check column
    get_column(Grid, Col, Column),
    \+ member(Number, Column),
    % Check 3x3 box
    get_box(Grid, Row, Col, Box),
    \+ member(Number, Box).

% Get a row from the grid
get_row(Grid, RowIndex, Row) :-
    nth0(RowIndex, Grid, Row).

% Get a column from the grid
get_column(Grid, ColIndex, Column) :-
    findall(Element, 
            (member(Row, Grid), nth0(ColIndex, Row, Element)), 
            Column).

% Get the 3x3 box containing cell (Row, Col)
get_box(Grid, Row, Col, Box) :-
    BoxRow is (Row // 3) * 3,
    BoxCol is (Col // 3) * 3,
    findall(Element,
            (between(0, 2, I),
             between(0, 2, J),
             RowIdx is BoxRow + I,
             ColIdx is BoxCol + J,
             nth0(RowIdx, Grid, GridRow),
             nth0(ColIdx, GridRow, Element)),
            Box).

% Simple backtracking Sudoku solver (alternative implementation)
solve_simple(Grid, Solution) :-
    (next_empty_cell(Grid, Row, Col) ->
        between(1, 9, Number),
        valid_move(Grid, Row, Col, Number),
        set_cell(Grid, Row, Col, Number, NewGrid),
        solve_simple(NewGrid, Solution)
    ;
        Solution = Grid
    ).

% Find the next empty cell (cell with 0)
next_empty_cell(Grid, Row, Col) :-
    nth0(Row, Grid, GridRow),
    nth0(Col, GridRow, 0),
    !.

% Set a cell value in the grid
set_cell(Grid, Row, Col, Value, NewGrid) :-
    set_row(Grid, Row, Col, Value, NewGrid).

set_row([], _, _, _, []).
set_row([H|T], 0, Col, Value, [NewRow|T]) :-
    set_element(H, Col, Value, NewRow).
set_row([H|T], Row, Col, Value, [H|NewT]) :-
    Row > 0,
    NewRow is Row - 1,
    set_row(T, NewRow, Col, Value, NewT).

set_element([], _, _, []).
set_element([_|T], 0, Value, [Value|T]).
set_element([H|T], Index, Value, [H|NewT]) :-
    Index > 0,
    NewIndex is Index - 1,
    set_element(T, NewIndex, Value, NewT).

% Helper predicate for membership
member(X, List, Index) :-
    nth0(Index, List, X).

% Example usage:
% ?- solve_and_print.
% ?- sudoku_puzzle(Puzzle), solve_sudoku(Puzzle, Solution).