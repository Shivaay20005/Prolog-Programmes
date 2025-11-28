% Facts - Family relationships
parent(john, mary).
parent(john, tom).
parent(mary, ann).
parent(mary, bob).
parent(tom, lisa).

male(john).
male(tom).
male(bob).
female(mary).
female(ann).
female(lisa).

% Rules - Family relationships
father(F, C) :- parent(F, C), male(F).
mother(M, C) :- parent(M, C), female(M).
grandparent(GP, GC) :- parent(GP, P), parent(P, GC).
sibling(S1, S2) :- parent(P, S1), parent(P, S2), S1 \= S2.