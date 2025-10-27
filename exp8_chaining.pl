/*
    Experiment 8: Forward and Backward Chaining in Prolog
    File: exp8_chaining.pl
    Aim: To demonstrate data-driven (forward) and goal-driven (backward) reasoning.
*/

% --- Knowledge Base ---
if(has_fever, has_flu).
if(has_cough, has_cold).
if(has_flu, needs_rest).
if(has_cold, drink_water).
if(needs_rest, take_leave).

fact(has_fever).
fact(has_cough).

% --- FORWARD CHAINING ---
forward_chain :-
    fact(X),
    if(X, Y),
    \+ fact(Y),
    assert(fact(Y)),
    write('Derived: '), write(Y), nl,
    forward_chain.
forward_chain.

% --- BACKWARD CHAINING ---
goal(X) :- fact(X).
goal(X) :- if(Y, X), goal(Y).

% --- Queries for backward reasoning ---
% ?- goal(needs_rest).
% ?- goal(drink_water).
% ?- forward_chain.
