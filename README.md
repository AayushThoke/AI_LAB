# AI_LAB Prolog Experiments

This repository contains several Prolog programs used for AI lab experiments (SWI‑Prolog compatible). This README explains prerequisites and how to run each file both interactively and from the command line.

## Prerequisites

- SWI‑Prolog installed
  - Download: https://www.swi-prolog.org/Download.html
  - Verify:
    ```bash
    swipl --version
    ```
- Recommended: a recent SWI‑Prolog (7.x/8.x/9.x)
- Encoding: files are UTF‑8 (default for SWI‑Prolog)

## Important Notes

- Embedded queries inside the files (lines with `?- ...`) are for documentation and will cause a syntax error if you consult the file as-is. Either:
  - Comment them out before consulting, or
  - Ignore them and run the queries yourself in the REPL after loading the file.
- `exp8_chaining.pl` uses `assert/1` to add `fact/1` at runtime. Declare `fact/1` dynamic to avoid a permission error:
  ```prolog
  :- dynamic fact/1.
  ```
  Add this line near the top of `exp8_chaining.pl` (after the comment header).

## Running Files (Interactive REPL)

1) Start SWI‑Prolog:
   ```bash
   swipl
   ```
2) Load a file (examples below assume you are in the repo root `AI_LAB-main/`):
   ```prolog
   ?- [Exp3_prolog].
   ?- [exp4_bfs_dfs].
   ?- [exp5_8puzzle].
   ?- [exp6_tictactoe].
   ?- [exp7_hill_climbing].
   ?- [exp8_chaining].
   ?- [exp10_planning].
   ```
3) Run the corresponding queries (see per-file sections below).

## Running Files (One‑shot from Terminal)

You can run a specific goal and exit SWI‑Prolog using `-s` (script), `-g` (goal), and `-t` (top-level/halt):

```bash
swipl -q -s file.pl -g goal -t halt
```

Examples are provided per file below.

---

## File: `Exp3_prolog.pl`
Family relationships (facts and rules).

- Load and query in REPL:
  ```prolog
  ?- [Exp3_prolog].
  ?- mother(pam, bob).
  ?- grandparent(X, jim).
  ```
- Command-line one‑shot:
  ```bash
  swipl -q -s Exp3_prolog.pl -g "mother(pam,bob), writeln(done)" -t halt
  swipl -q -s Exp3_prolog.pl -g "grandparent(X,jim), writeln(X), fail; true" -t halt
  ```

Note: If consulting errors due to `?-` lines inside the file, comment them and try again.

---

## File: `exp4_bfs_dfs.pl`
Breadth‑First Search and Depth‑First Search on a small graph.

- REPL:
  ```prolog
  ?- [exp4_bfs_dfs].
  ?- bfs(a, f).
  ?- dfs(a, f).
  ```
- Command-line:
  ```bash
  swipl -q -s exp4_bfs_dfs.pl -g "bfs(a,f)" -t halt
  swipl -q -s exp4_bfs_dfs.pl -g "dfs(a,f)" -t halt
  ```

Tip: The file repeats `edge/2` facts; this is harmless (just redundant).

---

## File: `exp5_8puzzle.pl`
8‑puzzle BFS solver with text rendering of states.

- REPL:
  ```prolog
  ?- [exp5_8puzzle].
  ?- solve([1,2,3,4,0,6,7,5,8], [1,2,3,4,5,6,7,8,0]).
  ```
- Command-line:
  ```bash
  swipl -q -s exp5_8puzzle.pl -g "solve([1,2,3,4,0,6,7,5,8],[1,2,3,4,5,6,7,8,0])" -t halt
  ```

---

## File: `exp6_tictactoe.pl`
Tic‑Tac‑Toe AI using minimax; prints the chosen move from a given start board.

- REPL:
  ```prolog
  ?- [exp6_tictactoe].
  ?- play.
  ```
- Command-line:
  ```bash
  swipl -q -s exp6_tictactoe.pl -g play -t halt
  ```

Board representation uses `x`, `o`, and `e` (empty).

---

## File: `exp7_hill_climbing.pl`
Simple hill climbing on a one‑dimensional heuristic (parabola peak).

- REPL:
  ```prolog
  ?- [exp7_hill_climbing].
  ?- start.
  ```
- Command-line:
  ```bash
  swipl -q -s exp7_hill_climbing.pl -g start -t halt
  ```

---

## File: `exp8_chaining.pl`
Forward and backward chaining over simple rules/facts.

- Required change (once): add this near the top to allow `assert/1` to add facts:
  ```prolog
  :- dynamic fact/1.
  ```
- REPL:
  ```prolog
  ?- [exp8_chaining].
  ?- forward_chain.
  ?- goal(needs_rest).
  ?- goal(drink_water).
  ```
- Command-line:
  ```bash
  swipl -q -s exp8_chaining.pl -g forward_chain -t halt
  swipl -q -s exp8_chaining.pl -g "goal(needs_rest)" -t halt
  ```

---

## File: `exp10_planning.pl`
Blocks‑world linear planner; prints the generated plan.

- REPL:
  ```prolog
  ?- [exp10_planning].
  ?- run.
  ```
- Command-line:
  ```bash
  swipl -q -s exp10_planning.pl -g run -t halt
  ```

---

## Troubleshooting

- **Syntax error when consulting a file**
  - Cause: In‑file `?- query.` lines. Comment them out or run the queries in the REPL instead.
- **Permission error: modifying static procedure `fact/1`**
  - Cause: Asserting `fact/1` without `dynamic` declaration in `exp8_chaining.pl`.
  - Fix: Add `:- dynamic fact/1.` near the top of that file.
- **Undefined predicate**
  - Ensure you loaded the correct file and spelled the predicate/arity correctly, e.g., `run/0` vs `run/1`.

## Directory

- Repository root: `AI_LAB-main/`
- Prolog files:
  - `Exp3_prolog.pl`
  - `exp4_bfs_dfs.pl`
  - `exp5_8puzzle.pl`
  - `exp6_tictactoe.pl`
  - `exp7_hill_climbing.pl`
  - `exp8_chaining.pl`
  - `exp10_planning.pl`
