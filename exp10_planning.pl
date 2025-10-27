% Define the pickup action
% Preconditions: Block is on 'From' (another block or table), Block is clear.
pickup(Block, From, State, NewState) :-
    on(Block, From),
    clear(Block, State),
    % Effects (State updates are handled by helper predicates)
    remove(Block, From, State, TempState),
    assert(on(Block, agent)),
    assert(holding(Block, TempState)),
    retract(State, TempState).

% Define the putdown action
% Preconditions: The agent is holding 'Block'.
putdown(Block, To, State, NewState) :-
    holding(Block, State),
    % Effects
    remove(holding(Block, State), State, TempState),
    assert(on(Block, To)),
    assert(clear(Block, TempState)),
    retract(State, TempState).

% Helper predicate to check if a block is clear (nothing is on top of it)
clear(Block, State) :- 
    \+ on(_, Block, State).

% Depth-first search to find the plan
dfs(State, Goal, _, []) :- 
    State = Goal.

dfs(State, Goal, Visited, [Action | Plan]) :- 
    move(State, Action, NewState), % 'move' would call pickup or putdown
    \+ member(NewState, Visited),  % Avoid cycles (revisiting states)
    dfs(NewState, Goal, [State | Visited], Plan).

//query
?- plan(Plan).
