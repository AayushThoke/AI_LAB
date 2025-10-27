% --- Hill Climbing Algorithm in Prolog ---

% Define possible moves (neighboring states)
neighbor(State, Neighbor) :-
    Neighbor is State + 1.
neighbor(State, Neighbor) :-
    Neighbor is State - 1.

% Define the heuristic function (higher is better)
heuristic(State, Value) :-
    Value is -((State - 5) * (State - 5)) + 25.
    % This is a parabola with max at State = 5, Value = 25

% Hill climbing process
hill_climb(CurrentState, CurrentValue, FinalState, FinalValue) :-
    neighbor(CurrentState, NextState),
    heuristic(NextState, NextValue),
    NextValue > CurrentValue, !,
    hill_climb(NextState, NextValue, FinalState, FinalValue).

hill_climb(State, Value, State, Value).

% Entry point
start :-
    StartState = 0,
    heuristic(StartState, StartValue),
    hill_climb(StartState, StartValue, FinalState, FinalValue),
    write('Starting at State: '), write(StartState), nl,
    write('Reached Peak at State: '), write(FinalState), nl,
    write('Final Value (Heuristic): '), write(FinalValue), nl.











% --- Query  ---
?- start.
