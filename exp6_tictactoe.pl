% --- Tic Tac Toe using Minimax Algorithm ---

% Define possible positions on the board (1 to 9)
pos(1). pos(2). pos(3). pos(4). pos(5). pos(6). pos(7). pos(8). pos(9).

% Winning combinations
win([X,X,X,_,_,_,_,_,_], X).
win([_,_,_,X,X,X,_,_,_], X).
win([_,_,_,_,_,_,X,X,X], X).
win([X,_,_,X,_,_,X,_,_], X).
win([_,X,_,_,X,_,_,X,_], X).
win([_,_,X,_,_,X,_,_,X], X).
win([X,_,_,_,X,_,_,_,X], X).
win([_,_,X,_,X,_,X,_,_], X).

% Evaluate board
value(Board, 1) :- win(Board, o), !.  % AI wins
value(Board, -1) :- win(Board, x), !. % Human wins
value(_, 0).                          % Draw or unfinished

% Generate all possible moves
move(Board, Player, NewBoard) :-
    nth1(Pos, Board, e),
    replace(Board, Pos, Player, NewBoard).

replace([_|T], 1, X, [X|T]).
replace([H|T], I, X, [H|R]) :-
    I > 1,
    I1 is I - 1,
    replace(T, I1, X, R).

% Minimax algorithm
minimax(Board, Player, Value) :-
    value(Board, Value), !.

minimax(Board, o, Value) :- % AI maximizes
    findall(V, (move(Board, o, NewB), minimax(NewB, x, V)), Values),
    max_list(Values, Value).

minimax(Board, x, Value) :- % Human minimizes
    findall(V, (move(Board, x, NewB), minimax(NewB, o, V)), Values),
    min_list(Values, Value).

% Find best move for AI (Player o)
best_move(Board, BestMove) :-
    findall(Value-Move,
        (move(Board, o, Move), minimax(Move, x, Value)),
        Moves),
    keysort(Moves, Sorted),
    reverse(Sorted, [_-BestMove|_]).

% Print the board
display_board([A,B,C,D,E,F,G,H,I]) :-
    write(A), write(' | '), write(B), write(' | '), write(C), nl,
    write('--+---+--'), nl,
    write(D), write(' | '), write(E), write(' | '), write(F), nl,
    write('--+---+--'), nl,
    write(G), write(' | '), write(H), write(' | '), write(I), nl.

% Example run
play :-
    InitialBoard = [x,e,e,e,o,e,e,e,x],
    display_board(InitialBoard),
    best_move(InitialBoard, Best),
    nl, write('AI chooses:'), nl,
    display_board(Best).




% --- query ---

?- play.

