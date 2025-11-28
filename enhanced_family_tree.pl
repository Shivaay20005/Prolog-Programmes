% Enhanced Family Tree Implementation in Prolog
% Demonstrates family relationships with more comprehensive rules

% Facts - Family relationships (parent/2)
parent(john, mary).
parent(john, tom).
parent(mary, ann).
parent(mary, bob).
parent(tom, lisa).
parent(tom, jim).
parent(lisa, pat).
parent(bob, kate).

% Gender facts
male(john).
male(tom).
male(bob).
male(jim).
male(pat).
female(mary).
female(ann).
female(lisa).
female(kate).

% Rules - Family relationships

% Father and mother relationships
father(F, C) :- parent(F, C), male(F).
mother(M, C) :- parent(M, C), female(M).

% Grandparent relationships
grandparent(GP, GC) :- parent(GP, P), parent(P, GC).
grandfather(GF, GC) :- grandparent(GF, GC), male(GF).
grandmother(GM, GC) :- grandparent(GM, GC), female(GM).

% Sibling relationships
sibling(S1, S2) :- parent(P, S1), parent(P, S2), S1 \= S2.
brother(B, S) :- sibling(B, S), male(B), B \= S.
sister(S, B) :- sibling(S, B), female(S), S \= B.

% Ancestor relationships
ancestor(A, D) :- parent(A, D).
ancestor(A, D) :- parent(A, P), ancestor(P, D).

% Descendant relationships
descendant(D, A) :- ancestor(A, D).

% Uncle and aunt relationships
uncle(U, N) :- brother(U, P), parent(P, N).
aunt(A, N) :- sister(A, P), parent(P, N).

% Cousin relationships
cousin(C1, C2) :- parent(P1, C1), parent(P2, C2), sibling(P1, P2).

% Great relationships
great_grandparent(GGP, GGC) :- parent(GGP, GP), grandparent(GP, GGC).

% Age relationships (assuming we have age information)
age(john, 75).
age(mary, 50).
age(tom, 45).
age(ann, 25).
age(bob, 23).
age(lisa, 20).
age(jim, 18).
age(pat, 2).
age(kate, 1).

younger(X, Y) :- age(X, AgeX), age(Y, AgeY), AgeX < AgeY.
older(X, Y) :- age(X, AgeX), age(Y, AgeY), AgeX > AgeY.

% Family tree visualization
show_family_tree :-
    write('Family Tree Visualization:'), nl,
    write('========================'), nl,
    forall(person(Person), (
        write(Person), write(': '),
        (father(Person, _) -> write('father, ') ; true),
        (mother(Person, _) -> write('mother, ') ; true),
        (parent(Person, _) -> write('parent, ') ; true),
        nl
    )).

% List all persons in the family
person(X) :- parent(X, _).
person(X) :- parent(_, X).

% Find all relatives of a person
relatives(Person, Relatives) :-
    findall(Relative, (
        relative(Person, Relative),
        Person \= Relative
    ), Relatives).

relative(X, Y) :- parent(X, Y).
relative(X, Y) :- parent(Y, X).
relative(X, Y) :- sibling(X, Y).
relative(X, Y) :- grandparent(X, Y).
relative(X, Y) :- grandparent(Y, X).
relative(X, Y) :- ancestor(X, Y).
relative(X, Y) :- ancestor(Y, X).

% Example queries and their expected results:
% ?- father(john, mary).          % true
% ?- mother(mary, bob).           % true
% ?- grandparent(john, ann).      % true
% ?- sibling(mary, tom).          % true
% ?- uncle(tom, ann).             % true
% ?- cousin(ann, lisa).           % true
% ?- ancestor(john, pat).         % true
% ?- relatives(mary, R).          % R = [john, ann, bob, tom]
% ?- show_family_tree.

% Additional family relationship rules
% First cousin once removed
first_cousin_once_removed(C1, C2) :-
    parent(C1, X), cousin(X, C2).
first_cousin_once_removed(C1, C2) :-
    parent(X, C1), cousin(X, C2).

% Second cousins
second_cousin(C1, C2) :-
    grandparent(GP, C1), grandparent(GP, C2),
    \+ (parent(P1, C1), parent(P2, C2), sibling(P1, P2)),
    C1 \= C2.

% In-laws (simplified)
spouse(X, Y) :- parent(X, Child), parent(Y, Child), X \= Y.

% Step relationships (simplified)
step_parent(SP, C) :- spouse(SP, P), parent(P, C), \+ parent(SP, C).
step_child(SC, SP) :- step_parent(SP, SC).

% Half siblings
half_sibling(HS1, HS2) :-
    parent(P, HS1), parent(P, HS2),
    parent(P1, HS1), parent(P2, HS2),
    P1 \= P2, P1 \= P, P2 \= P,
    HS1 \= HS2.

% Family statistics
family_size(Size) :-
    findall(X, (parent(X, _); parent(_, X)), Members),
    sort(Members, UniqueMembers),
    length(UniqueMembers, Size).

oldest_person(Person) :-
    findall(Age-Person, age(Person, Age), AgeList),
    max_list(AgeList, _-Person).

youngest_person(Person) :-
    findall(Age-Person, age(Person, Age), AgeList),
    min_list(AgeList, _-Person).

% Helper predicates
max_list([X], X).
max_list([H|T], Max) :-
    max_list(T, TailMax),
    (H @> TailMax -> Max = H ; Max = TailMax).

min_list([X], X).
min_list([H|T], Min) :-
    min_list(T, TailMin),
    (H @< TailMin -> Min = H ; Min = TailMin).