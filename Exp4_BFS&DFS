% --- Define the graph edges ---
edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, f).
edge(c, g).
edge(d, h).
edge(d, i).

% --- BFS implementation ---
bfs(Start, Goal) :-
    bfs_queue([[Start]], Goal).

% Base case: when goal is found
bfs_queue([[Goal|Path]|_], Goal) :-
    reverse([Goal|Path], Solution),
    write('BFS Solution: '), write(Solution), nl.

% Recursive case
bfs_queue([Path|Paths], Goal) :-
    extend(Path, NewPaths),
    append(Paths, NewPaths, UpdatedPaths),
    bfs_queue(UpdatedPaths, Goal).

% Extend path by finding neighbors
extend([Node|Path], NewPaths) :-
    findall([NewNode, Node|Path],
            (edge(Node, NewNode), \+ member(NewNode, [Node|Path])),
            NewPaths),
    !.
extend(_, []).










% --- Define the same graph ---
edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, f).
edge(c, g).

% --- DFS implementation ---
dfs(Start, Goal) :-
    dfs_helper(Start, Goal, [], Path),
    reverse(Path, RevPath),
    write('DFS Path: '), write(RevPath), nl.

% Base case
dfs_helper(Node, Node, Visited, [Node|Visited]).

% Recursive case
dfs_helper(Current, Goal, Visited, Path) :-
    edge(Current, Next),
    \+ member(Next, Visited),
    dfs_helper(Next, Goal, [Current|Visited], Path).







% --- BFS Query ---

?- bfs(a, f).

% --- DFS implementation ---

?- dfs(a, f).
