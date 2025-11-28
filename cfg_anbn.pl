% Context-Free Grammar Recognizer for a^n b^n language in Prolog

% Grammar rules for language {a^n b^n | n >= 0}
% S -> aSb | ε (empty string)

% Recognizer for a^n b^n language
% Base case: empty string (n=0)
recognize_anbn([]).

% Recursive case: aSb
recognize_anbn([a|Rest]) :-
    append(Middle, [b], Rest),
    recognize_anbn(Middle).

% Alternative implementation using difference lists for better efficiency
% S --> []
% S --> [a], S, [b]

% Difference list implementation
recognize_anbn_dl(Input) :-
    s(Input, []).

% Grammar rules using difference lists
s([], []).
s([a|In], Out) :-
    s(In, Mid),
    Mid = [b|Out].

% Generate strings in the language a^n b^n
generate_anbn(0, []).
generate_anbn(N, [a|Rest]) :-
    N > 0,
    N1 is N - 1,
    generate_anbn(N1, Middle),
    append(Middle, [b], Rest).

% Check if a string belongs to the language
check_anbn(String) :-
    recognize_anbn(String),
    write('String '), write(String), write(' belongs to the language a^n b^n.'), nl.

check_anbn(String) :-
    \+ recognize_anbn(String),
    write('String '), write(String), write(' does NOT belong to the language a^n b^n.'), nl.

% Test cases
test_cases :-
    write('Testing a^n b^n language recognizer:'), nl,
    write('===================================='), nl, nl,
    
    % Test case 1: Empty string (n=0)
    write('1. Empty string: '),
    check_anbn([]),
    
    % Test case 2: n=1
    write('2. "ab": '),
    check_anbn([a,b]),
    
    % Test case 3: n=2
    write('3. "aabb": '),
    check_anbn([a,a,b,b]),
    
    % Test case 4: n=3
    write('4. "aaabbb": '),
    check_anbn([a,a,a,b,b,b]),
    
    % Test case 5: Invalid string
    write('5. "aab": '),
    check_anbn([a,a,b]),
    
    % Test case 6: Invalid string
    write('6. "abab": '),
    check_anbn([a,b,a,b]),
    
    % Test case 7: Invalid string
    write('7. "ba": '),
    check_anbn([b,a]).

% Generate and display first few strings in the language
generate_examples :-
    write('Generating examples of a^n b^n language:'), nl,
    write('======================================='), nl,
    forall(between(0, 5, N), (
        generate_anbn(N, String),
        write('n='), write(N), write(': '), write(String), nl
    )).

% More complex CFG recognizer for balanced parentheses
% Grammar: S -> (S) | SS | ε

% Recognizer for balanced parentheses
recognize_balanced([]).
recognize_balanced([open|Rest]) :-
    append(First, [close|Second], Rest),
    recognize_balanced(First),
    recognize_balanced(Second).

% Alternative implementation for balanced parentheses
balanced_parentheses([]).
balanced_parentheses([open|Rest]) :-
    split_into_balanced(Rest, Inside, Outside),
    balanced_parentheses(Inside),
    balanced_parentheses(Outside).

% Split a list into balanced and remaining parts
split_into_balanced(List, Balanced, Remaining) :-
    find_prefix_balanced(List, 0, Balanced, Remaining).

find_prefix_balanced([], _, [], []).
find_prefix_balanced([close|T], Count, [], [close|T]) :-
    Count = 0.
find_prefix_balanced([close|T], Count, [close|Balanced], Remaining) :-
    Count > 0,
    NewCount is Count - 1,
    find_prefix_balanced(T, NewCount, Balanced, Remaining).
find_prefix_balanced([open|T], Count, [open|Balanced], Remaining) :-
    NewCount is Count + 1,
    find_prefix_balanced(T, NewCount, Balanced, Remaining).

% Test balanced parentheses
test_parentheses :-
    write('Testing balanced parentheses recognizer:'), nl,
    write('======================================'), nl, nl,
    
    % Test case 1: Empty string
    write('1. Empty string: '),
    (recognize_balanced([]) ->
        write('Balanced'), nl
    ;
        write('Not balanced'), nl
    ),
    
    % Test case 2: ()
    write('2. "()": '),
    (recognize_balanced([open, close]) ->
        write('Balanced'), nl
    ;
        write('Not balanced'), nl
    ),
    
    % Test case 3: (())
    write('3. "(())": '),
    (recognize_balanced([open, open, close, close]) ->
        write('Balanced'), nl
    ;
        write('Not balanced'), nl
    ),
    
    % Test case 4: ()()
    write('4. "()()": '),
    (recognize_balanced([open, close, open, close]) ->
        write('Balanced'), nl
    ;
        write('Not balanced'), nl
    ),
    
    % Test case 5: (()())
    write('5. "(()())": '),
    (recognize_balanced([open, open, close, open, close, close]) ->
        write('Balanced'), nl
    ;
        write('Not balanced'), nl
    ),
    
    % Test case 6: ((())
    write('6. "((())": '),
    (recognize_balanced([open, open, open, close, close]) ->
        write('Balanced'), nl
    ;
        write('Not balanced'), nl
    ).

% Helper predicate for append
append([], L, L).
append([H|T], L, [H|R]) :-
    append(T, L, R).

% Example usage:
% ?- recognize_anbn([a,a,b,b]).
% ?- test_cases.
% ?- generate_examples.
% ?- recognize_balanced([open, open, close, close]).
% ?- test_parentheses.