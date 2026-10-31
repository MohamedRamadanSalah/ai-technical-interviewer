# Live Coding Questions

A `livecode` question makes the candidate **write working code during the
interview**. It is the highest-signal question type in any kit and the most
expensive in time — one good live-coding task is worth more than six theory
questions, and it should be budgeted like it.

## Relation to the base question block

A `livecode` question is the base block of `output-contract.md` §3 with four
fields **substituted** and the rest added. The substitutions are exact — a
`livecode` block has no `Expected key points`, `Model answer`, `Acceptable
variants`, or `Answer shape`:

| Base field | In a `livecode` question |
|---|---|
| `Expected key points` | → **`Requirements`** — same bracket weighting, same yes/no awarding |
| `Model answer` | → **`Reference solution`** — a file path, never read aloud |
| `Red flags` | → **`Deliberate traps`** — same discriminating role |
| `Acceptable variants` | → covered by **`Craft rubric`**, which says what other correct shapes are worth |
| `Answer shape` | → covered by **`Mode`**, **`Runtime`**, and **`Starter contents`** |

**Carried unchanged from the base block:** `Ask`, `Time budget`, `Probes`,
`Scoring anchors`, `Depends on`.

## Where it sits in the kit

A kit that includes live coding declares it once in `kit.md`:

```markdown
## Live coding

- **Segment:** yes
- **Placement:** after L2, scored into L2
- **Questions:** Q-LC-01
- **Total budget:** 25 min
- **Mode:** runnable
- **Runtime:** Python 3.11 — `python3 solution.py`
- **Environment prerequisites:** `python3` on PATH. If unavailable, the segment
  degrades to `review-only` and the report says so.
- **Workspace:** `livecode/` inside the kit folder
```

Live-coding questions use the ID form `Q-LC-<nn>` rather than a level number —
they span levels by design. They still carry a `weight`, and the **Placement**
line says which level's score they count toward.

`livecode` counts as an **applied** type for the 60% floor.

## Two modes

| Mode | Meaning |
|---|---|
| `runnable` | The code can actually be executed. The candidate may run it; the interviewer runs the hidden tests at submission. Far stronger signal — prefer it whenever the runtime is available. |
| `review-only` | Execution is genuinely impossible here (needs a live database, a cluster, a device). Scored by reading the code against the requirements and the reference solution. |

Choose `review-only` only when execution is actually impossible. "It would be
fiddly to set up" is not a reason — the signal difference is large.

## Additional fields

````markdown
## Q-LC-01 — livecode — weight 5

**Ask:** <the task, read verbatim. States the problem, the constraints, and what
"done" means. Does NOT state the edge cases — finding those is the test.>

**Time budget:** 25 min

**Mode:** runnable

**Runtime:** Python 3.11 — `python3 solution.py`

**Starter file:** `livecode/Q-LC-01/solution.py`

**Starter contents:**
```python
def merge_windows(windows):
    """<signature + one worked example. No hint toward the algorithm.>"""
    pass
```

**Requirements:** <weighted exactly like Expected key points. These are what the
code must *do*, phrased so met/not-met is a yes/no.>
- [4] Correct output on the ordinary case
- [3] Handles <the deliberate trap> correctly
- [2] Handles empty and single-element input
- [2] Stays within <complexity bound> at the stated input size
- [1] Readable: names say what things are, no dead code

**Deliberate traps:** <the cases the task statement does not mention, which a
candidate who is actually thinking will find. This is the discriminator — name
each one and say what a candidate who misses it produces.>

**Hidden tests:** `livecode/Q-LC-01/tests.py` — <what they cover, and which
requirement each group maps to. NEVER shown or described to the candidate, and
never run in front of them.>

**Reference solution:** `livecode/Q-LC-01/reference.py` — <never shown.>

**Craft rubric:** <what good looks like beyond passing: structure, naming,
whether edge handling is deliberate or accidental, whether the complexity is
appropriate. Drives the ±15 craft adjustment.>

**Probes:** <asked while they work or after submission — never leading>
- "Talk me through what that line does."
- "What input would break this?"

**Scoring anchors:**
- 100 — all requirements met, traps handled deliberately, clean
- 70 — ordinary case correct, one trap missed
- 40 — approach is sound, code doesn't work
- 0 — no working approach, or nothing written

**Depends on:** none
````

## Designing the task

- **20–30 minutes of real work** — not 5, not 60. Too small tests typing; too
  large tests only time management.
- **The trap is the question.** A task with no edge case has no discrimination:
  everyone who can code produces the same happy path. Put in one or two cases
  the statement does not mention but a careful person finds — empty input,
  duplicate keys, adjacent-versus-overlapping boundaries, an off-by-one at a
  range end, an input that is already sorted.
- **State constraints numerically.** "Up to 10^6 elements" makes an O(n²)
  solution wrong; "a large list" makes it arguable.
- **Standard library only**, unless the source material makes a specific
  framework the whole point. Never require a library the candidate may not know.
- **The starter must not leak the approach.** A signature and one worked
  example — never a skeleton whose comments are the algorithm's steps.
- **Write hidden tests to the requirements**, one group per weighted
  requirement, so a failing group maps to a specific unmet requirement. Include
  the traps. Tests must not print hints on failure: a bare assertion is better
  than a helpful message here.
- **Write and run the reference solution.** If you did not execute it, you do
  not know the task is solvable as stated or that the tests pass on it. That is
  the builder's job, not the interviewer's.

## Scoring

```
Sq = 100 × (Σ met requirement weights) / (Σ all requirement weights)
```

In `runnable` mode, requirement coverage is decided by the hidden tests, not by
reading the code hopefully.

Then apply the **craft adjustment**: up to ±15 from the craft rubric, after the
requirement score and before the caps. Craft cannot rescue code that does not
work — the caps in `evaluation.md` §2 still bind, including the livecode one:
**`runnable` code that never executed successfully is capped at 30**, however
elegant it reads.
