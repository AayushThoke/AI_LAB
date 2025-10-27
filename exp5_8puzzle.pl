% --- Representation of moves in the 8-puzzle ---

% Move blank tile left
move([A,B,0,D,E,F,G,H,I], [A,0,B,D,E,F,G,H,I]).
move([A,B,C,D,0,F,G,H,I], [A,0,C,D,B,F,G,H,I]).
move([A,B,C,D,E,F,G,0,I], [A,B,C,0,E,F,G,D,I]).

% Move blank tile right
move([0,B,C,D,E,F,G,H,I], [B,0,C,D,E,F,G,H,I]).
move([A,0,C,D,E,F,G,H,I], [A,C,0,D,E,F,G,H,I]).
move([A,B,C,D,E,0,G,H,I], [A,B,C,D,0,E,G,H,I]).

% Move blank tile up
move([A,B,C,0,E,F,G,H,I], [0,B,C,A,E,F,G,H,I]).
move([A,B,C,D,0,F,G,H,I], [A,0,C,D,B,F,G,H,I]).
move([A,B,C,D,E,F,0,H,I], [A,B,0,D,E,F,G,H,I]).

% Move blank tile down
move([0,B,C,D,E,F,G,H,I], [D,B,C,0,E,F,G,H,I]).
move([A,0,C,D,E,F,G,H,I], [A,E,C,D,0,F,G,H,I]).
move([A,B,0,D,E,F,G,H,I], [A,B,F,D,E,0,G,H,I]).

% --- Breadth-First Search ---

bfs([[Goal|Path]|_], Goal, [Goal|Path]).
bfs([Path|Paths], Goal, Solution) :-
    extend(Path, NewPaths),
    append(Paths, NewPaths, UpdatedPaths),
    bfs(UpdatedPaths, Goal, Solution).

extend([State|Path], NewPaths) :-
    findall([NewState,State|Path],
            (move(State, NewState), \+ member(NewState, [State|Path])),
            NewPaths),
    !.
extend(_, []).

% --- Starting the search ---
solve(Start, Goal) :-
    bfs([[Start]], Goal, Path),
    reverse(Path, Solution),
    write('Solution Path: '), nl,
    print_states(Solution).

% --- Displaying each state nicely ---
print_states([]).
print_states([H|T]) :-
    print_state(H),
    nl,
    print_states(T).

print_state([A,B,C,D,E,F,G,H,I]) :-
    write(A), write(' '), write(B), write(' '), write(C), nl,
    write(D), write(' '), write(E), write(' '), write(F), nl,
    write(G), write(' '), write(H), write(' '), write(I), nl.







% --- Query---
?- solve([1,2,3,4,0,6,7,5,8], [1,2,3,4,5,6,7,8,0]).



