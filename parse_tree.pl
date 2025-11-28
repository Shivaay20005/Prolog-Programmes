% Parse Tree Generator in Prolog
% Implements a context-free grammar parser for English sentences

% Define the grammar rules for a simple English subset
% Sentence (S) -> Noun Phrase (NP) + Verb Phrase (VP)
s(s(NP, VP)) --> np(NP), vp(VP).

% Noun Phrase (NP) -> Determiner (Det) + Noun (N) | Determiner + Adjective + Noun | Proper Noun
np(np(Det, N)) --> det(Det), n(N).
np(np(Det, Adj, N)) --> det(Det), adj(Adj), n(N).
np(np(PN)) --> pn(PN).

% Verb Phrase (VP) -> Verb (V) | Verb + Noun Phrase | Verb + Preposition + Noun Phrase
vp(vp(V)) --> v(V).
vp(vp(V, NP)) --> v(V), np(NP).
vp(vp(V, Prep, NP)) --> v(V), prep(Prep), np(NP).

% Lexicon definitions
% Determiners
det(det(the)) --> [the].
det(det(a)) --> [a].
det(det(an)) --> [an].

% Nouns
n(n(cat)) --> [cat].
n(n(dog)) --> [dog].
n(n(man)) --> [man].
n(n(woman)) --> [woman].
n(n(book)) --> [book].
n(n(telescope)) --> [telescope].
n(n(park)) --> [park].

% Proper nouns
pn(pn(john)) --> [john].
pn(pn(mary)) --> [mary].

% Adjectives
adj(adj(big)) --> [big].
adj(adj(small)) --> [small].
adj(adj(red)) --> [red].
adj(adj(blue)) --> [blue].

% Verbs
v(v(sees)) --> [sees].
v(v(reads)) --> [reads].
v(v(chases)) --> [chases].
v(v(walks)) --> [walks].

% Prepositions
prep(prep(in)) --> [in].
prep(prep(with)) --> [with].
prep(prep(from)) --> [from].
prep(prep(to)) --> [to].

% Predicate to parse a sentence and generate a parse tree
parse_sentence(Sentence, ParseTree) :-
    s(ParseTree, Sentence, []).

% Pretty print the parse tree
print_parse_tree(Tree) :-
    print_tree(Tree, 0).

print_tree(Term, Indent) :-
    Term =.. [Functor|Args],
    print_indent(Indent),
    write(Functor), nl,
    NewIndent is Indent + 2,
    print_args(Args, NewIndent).

print_args([], _).
print_args([H|T], Indent) :-
    (is_list(H) ->
        (H = [] ->
            print_indent(Indent),
            write('[]'), nl
        ;
            print_list(H, Indent)
        )
    ;
        (atomic(H) ->
            print_indent(Indent),
            write(H), nl
        ;
            print_tree(H, Indent)
        )
    ),
    print_args(T, Indent).

print_list([], _).
print_list([H|T], Indent) :-
    print_indent(Indent),
    write(H), nl,
    print_list(T, Indent).

print_indent(0).
print_indent(N) :-
    N > 0,
    write(' '),
    N1 is N - 1,
    print_indent(N1).

% Sample sentences to parse
sample_sentence1([the, cat, sees, the, dog]).
sample_sentence2([a, small, man, reads, a, book]).
sample_sentence3([john, walks, in, the, park]).
sample_sentence4([mary, chases, the, red, cat, with, a, telescope]).

% Parse and display sample sentences
demo_parse :-
    write('Parsing Sample Sentences:'), nl,
    write('========================'), nl, nl,
    
    write('1. "the cat sees the dog"'), nl,
    sample_sentence1(S1),
    (parse_sentence(S1, Tree1) ->
        print_parse_tree(Tree1)
    ;
        write('  Failed to parse'), nl
    ), nl,
    
    write('2. "a small man reads a book"'), nl,
    sample_sentence2(S2),
    (parse_sentence(S2, Tree2) ->
        print_parse_tree(Tree2)
    ;
        write('  Failed to parse'), nl
    ), nl,
    
    write('3. "john walks in the park"'), nl,
    sample_sentence3(S3),
    (parse_sentence(S3, Tree3) ->
        print_parse_tree(Tree3)
    ;
        write('  Failed to parse'), nl
    ), nl,
    
    write('4. "mary chases the red cat with a telescope"'), nl,
    sample_sentence4(S4),
    (parse_sentence(S4, Tree4) ->
        print_parse_tree(Tree4)
    ;
        write('  Failed to parse'), nl
    ).

% Helper predicate to check if a term is a list
is_list([]).
is_list([_|_]).

% Example usage:
% ?- sample_sentence1(S), parse_sentence(S, Tree).
% ?- demo_parse.
% ?- parse_sentence([the, cat, sees, the, dog], Tree).