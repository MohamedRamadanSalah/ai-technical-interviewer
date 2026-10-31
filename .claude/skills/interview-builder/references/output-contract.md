# Interview Kit — File Contract v1

Every kit the builder produces is a folder of `.md` files. The `interviewer`
skill parses these exact structures, so **headings, IDs, and field labels are
load-bearing** — do not rename or reorder them, do not add fields the contract
does not define, and do not skip a field because it "doesn't apply" (write
`none` instead).

```
<kit-name>/
  kit.md            # manifest: topic, levels, thresholds, source provenance
  rules.md          # interviewer conduct rules (binding, read first)
  questions.md      # question bank + answer key (single or split by level)
  evaluation.md     # metric definitions + formulas + report schema
  livecode/         # only when the kit has a live-coding segment
    Q-LC-01/
      solution.py   # starter file the candidate edits
      tests.py      # hidden tests — never shown, run once at submission
      reference.py  # reference solution — never shown
```

For large topics, `questions.md` may be split into `questions-L1.md`,
`questions-L2.md`, … The manifest must then list each file under `Question
files`.

---

## 1. `kit.md`

```markdown
# Interview Kit: <Topic>

- **Kit ID:** <kebab-case-slug>
- **Built:** <YYYY-MM-DD>
- **Source file:** <path to the source .md>
- **Role target:** <e.g. Mid-level Backend Engineer>
- **Total questions:** <n>
- **Question files:** questions.md
- **Contract version:** 1

## Levels

| Level | Name | Questions | Pass threshold | Gate |
|-------|------|-----------|----------------|------|
| L1 | Foundations | 6 | 70% | Must pass to reach L2 |
| L2 | Applied | 7 | 65% | Must pass to reach L3 |
| L3 | Depth & Design | 5 | 60% | Terminal |

## Live coding

Present only when the kit has a live-coding segment. Full field list in
`references/livecode-contract.md`.

- **Segment:** yes | no
- **Placement:** <where it runs, and which level's score it counts toward>
- **Questions:** Q-LC-01
- **Total budget:** <minutes>
- **Mode:** runnable | review-only
- **Runtime:** <language/version — the exact run command>
- **Environment prerequisites:** <what must exist; the fallback if it doesn't>
- **Workspace:** livecode/

## Scope

**In scope:** <bullet list of subtopics drawn from the source + research>
**Out of scope:** <what the interviewer must NOT ask about>

## Research provenance

| Claim / area | Source | Retrieved | Confidence |
|---|---|---|---|
| <what was verified> | <URL or "model knowledge"> | <date or n/a> | high/med/low |

## Known-unstable areas

Facts that change between versions/releases. The interviewer must accept any
answer consistent with a named version rather than a single "correct" string.

- <area> — <why it varies>
```

---

## 2. `rules.md`

Conduct rules the interviewer is bound by. Contains the fixed boilerplate block
(copy verbatim from `references/rules-boilerplate.md`) plus a
`## Topic-specific rules` section the builder generates — e.g. which terminology
counts as equivalent, which common misconceptions must be marked wrong even when
stated confidently, which tradeoff answers are legitimately two-sided.

---

## 3. `questions.md`

One `##` block per question. **The ID is the primary key** — the interviewer
cites it in the report and in its running notes.

````markdown
# Question Bank: <Topic>

## Q-L2-04 — scenario — weight 3

**Ask:** <the exact question text to read to the candidate, verbatim>

**Time budget:** 4 min

**Answer shape:** <one line — what a complete answer structurally contains,
e.g. "names the failure mode, gives a mitigation, states its cost">

**Expected key points:**
- [3] <point — the number in brackets is that point's weight>
- [2] <point>
- [1] <point>

**Model answer:** <2–6 sentences. The answer key. NEVER read aloud.>

**Acceptable variants:** <answers that differ in wording/approach but are
correct, or `none`>

**Red flags:** <specific wrong or bluffed claims that indicate absence of real
understanding, or `none`>

**Probes:** <follow-ups to use ONLY when the answer is incomplete or vague.
Probes must not contain the answer.>
- <probe 1>
- <probe 2>

**Scoring anchors:**
- 100 — <what a full-credit answer covers>
- 70 — <solid but missing one secondary point>
- 40 — <recognises the concept, cannot apply it>
- 0 — <no answer, wrong answer, or fabricated>

**Depends on:** Q-L1-02   <!-- or `none` -->
````

Field rules:

- **ID** — `Q-L<level>-<nn>`, zero-padded, unique across the whole kit.
- **type** — one of `theory` | `scenario` | `practical` | `debug` | `tradeoff`
  | `livecode`. **`theory` may be at most 40% of the bank**, so the applied
  types — `scenario`, `practical`, `debug`, `tradeoff`, `livecode` — are at
  least 60%. This is one rule stated from both ends; count `theory` and check it.
- **`livecode` questions carry extra fields** and use the ID form `Q-LC-<nn>`.
  See `references/livecode-contract.md` — it is additive to this block, not a
  replacement for it.
- **weight** — integer 1–5. Contributes to the level score denominator.
- **Expected key points** — 2–6 points, each bracket-weighted. The sum of a
  question's point weights is its full credit.
- **Model answer** and **Red flags** are answer-key material. `rules.md` forbids
  the interviewer from surfacing them before the report.

---

## 4. `evaluation.md`

Generated by copying `references/evaluation-template.md` verbatim, then
appending a `## Topic-specific behavioral notes` section — e.g. what "hedging"
looks like in this domain, whether "it depends" is evasion or correct.

The template defines the observation tag set, the percentage formulas, the
personality trait rubric, and the final report schema. Do not modify the
formulas per kit — comparability across candidates depends on them being fixed.
