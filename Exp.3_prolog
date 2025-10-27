% --- Facts ---
female(pam).
female(liz).
female(pat).
female(ann).

male(tom).
male(bob).
male(peter).
male(jim).

parent(pam, bob).
parent(tom, bob).
parent(tom, liz).
parent(bob, ann).
parent(bob, pat).
parent(pat, jim).
parent(bob, peter).
parent(peter, jim).

% --- Rules ---
mother(X, Y) :- parent(X, Y), female(X).
father(X, Y) :- parent(X, Y), male(X).

sister(X, Y) :- parent(Z, X), parent(Z, Y), female(X), X \== Y.
brother(X, Y) :- parent(Z, X), parent(Z, Y), male(X), X \== Y.

grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
grandmother(X, Y) :- mother(X, Z), parent(Z, Y).
grandfather(X, Y) :- father(X, Z), parent(Z, Y).

uncle(X, Y) :- brother(X, Z), parent(Z, Y).
aunt(X, Y) :- sister(X, Z), parent(Z, Y).


% --- Output_commands ---
?- mother(pam, bob).
?- grandparent(X, jim).



