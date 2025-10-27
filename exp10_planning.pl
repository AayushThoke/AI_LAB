% ------------------- BLOCKS WORLD PLANNER -------------------

% Initial and Goal States
initial_state([on(a,b), on(b,c), on(c,table), clear(a)]).

% --- FIX 1: Re-order the goal state ---
% This linear planner needs a solvable order.
% We must put 'a' on the table first, then stack 'b' on 'a', then 'c' on 'b'.
goal_state([on(a,table), on(b,a), on(c,b)]).

% --- FIX 2: Remove the conflicting clear/2 rule ---
% clear(Block, State) :-
%     \+ member(on(_, Block), State).

% --- FIX 3: Add a helper to check the state list for 'clear' ---
% This correctly checks the state list and handles the 'table'.
is_clear(table, _) :- !. % The table is always "clear" to move onto
is_clear(Block, State) :-
    member(clear(Block), State).

% Move predicate: move a block from one place to another
move(Block, From, To, State, NewState) :-
    select(on(Block, From), State, Temp1),
    append([on(Block, To)], Temp1, Temp2),
    make_clear(From, Temp2, Temp3),
    make_unclear(To, Temp3, NewState).

make_clear(table, State, State) :- !.
make_clear(Block, State, [clear(Block)|State]).

% --- FIX 4: Make 'make_unclear' more robust ---
% The original would fail if 'clear(Block)' wasn't in the list.
% This version removes it if it exists, or does nothing if it doesn't.
make_unclear(table, State, State) :- !.
make_unclear(Block, State, NewState) :-
    (select(clear(Block), State, NewState) -> true ; NewState = State).

% Check if a goal is already satisfied
achieved([], State, State, []).
achieved([Goal|Rest], State, FinalState, Plan) :-
    member(Goal, State),
    achieved(Rest, State, FinalState, Plan).

% --- FIX 5: Update 'achieved' to use the correct 'is_clear' helper ---
achieved([on(X,Y)|Rest], State, FinalState, [move(X,From,Y)|Plan]) :-
    member(on(X,From), State),
    is_clear(X, State),           % Changed from clear(X, State)
    is_clear(Y, State),           % Changed from clear(Y, State)
    move(X, From, Y, State, NewState),
    achieved(Rest, NewState, FinalState, Plan).

% Plan: find sequence of actions to achieve goal
plan(Init, Goal, Plan) :-
    achieved(Goal, Init, _, Plan).
    % Removed (Plan \= []) check to allow 0-step plans if goal = init

% Run program
run :-
    initial_state(Init),
    goal_state(Goal),
    writeln('--- BLOCKS WORLD PLANNING ---'),
    writeln('Initial State:'), writeln(Init),
    writeln('Goal State:'), writeln(Goal),
    ( plan(Init, Goal, Plan) ->
        nl, writeln('Generated Plan:'),
        print_actions(Plan),
        writeln('✅ Goal achieved successfully.'), !
    ;
        writeln('❌ No valid plan found.'), fail
    ).

print_actions([]).
print_actions([move(X,From,To)|Rest]) :-
    format('Action: Move ~w from ~w to ~w~n', [X, From, To]),
    print_actions(Rest).

% ------------------- END -------------------
