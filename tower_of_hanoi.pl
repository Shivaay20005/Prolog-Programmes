% Tower of Hanoi implementation in Prolog
% tower_of_hanoi(N) - Move N disks from peg A to peg C using peg B as auxiliary

% Base case: Moving 1 disk
move(1, Source, Target, _) :-
    write('Move disk from '), write(Source), write(' to '), write(Target), nl.

% Recursive case: Move N disks
move(N, Source, Target, Auxiliary) :-
    N > 1,
    M is N - 1,
    move(M, Source, Auxiliary, Target),
    move(1, Source, Target, Auxiliary),
    move(M, Auxiliary, Target, Source).

% Main predicate to solve Tower of Hanoi
tower_of_hanoi(N) :-
    move(N, 'A', 'C', 'B').

% Example usage:
% ?- tower_of_hanoi(3).
% ?- tower_of_hanoi(4).