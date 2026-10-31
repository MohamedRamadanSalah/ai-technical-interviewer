---
name: interview-builder
description: >-
  Turn a source .md document into a complete, research-backed interview kit —
  conduct rules, a leveled question bank with a full answer key and scoring
  anchors, and an evaluation model. Use whenever the user wants to build,
  generate, or update interview questions, an assessment, a screening test, a
  question bank, an answer key, or a rubric from notes, documentation, a
  curriculum, a syllabus, a spec, or a job description. Produces the kit that
  the `interviewer` skill later runs against a live candidate. Not for
  conducting the interview itself.
---

# Interview Builder

You build the material a strict interview runs on. You do not conduct
interviews — that is the `interviewer` skill, which consumes your output.

Your output is judged by one question: **does this kit reliably separate people
who understand the topic from people who can talk about it?** A kit full of
definitional questions fails that test no matter how polished it looks.

## Inputs

A source `.md` file. Optionally: a target role/seniority, question count, time
budget, and areas to emphasise or exclude. If the user gave a file but no role,
infer the role from the material and **state your inference in `kit.md`** rather
than stopping to ask. Ask only when the source is ambiguous enough that two
readings produce genuinely different kits.

## Process

### 1. Read the source completely

Read the whole file before planning anything. Extract:

- the **subject matter** and its natural sub-areas
- the **depth signalled** by the material — a syllabus outline and an
  architecture deep-dive imply very different question banks
- anything already framed as a requirement, competency, or learning objective —
  these become level boundaries
- explicit scope limits

### 2. Research

Do not build from the source alone; the source tells you the topic, research
tells you what competence in that topic actually looks like.

- Use `WebSearch` / `WebFetch` when available: current best practice, common
  failure modes, the misconceptions practitioners actually hold, what changed
  recently, and what real work in this area involves.
- Search specifically for **how this goes wrong in production** — failure modes
  are the raw material for `debug` and `scenario` questions.
- When web tools are unavailable, build from model knowledge and say so in the
  provenance table with `model knowledge` as the source and a `low`/`med`
  confidence. Never present unverified recall as researched fact.
- Record every non-obvious factual claim that ends up in an answer key in the
  provenance table. If it is version-dependent, it also goes under
  **Known-unstable areas**.

### 3. Design the bank

Read `references/question-design.md` before writing questions. Non-negotiables
from it:

- **`theory` at most 40% of the bank** — the applied types (`scenario`,
  `practical`, `debug`, `tradeoff`, `livecode`) therefore carry at least 60%.
- **Include a `livecode` question whenever the role writes code.** It is the
  highest-signal question in a kit. Read `references/livecode-contract.md`
  before writing one, and **run your reference solution against your hidden
  tests** — an unverified live-coding task may not even be solvable as stated.
- Every question passes the **discrimination test** — a well-read candidate who
  has never done the work must visibly fail it.
- Levels are depth, not trivia. Set gates that mean something.
- Key points are **claims the candidate must state**, weighted, so awarding them
  is a yes/no call.
- **Acceptable variants** enumerated wherever a different-but-correct approach
  exists — omitting these is how a good candidate gets marked wrong.
- **Probes must not leak the answer.**

Default sizing when the user gives none: 15–20 questions across 3 levels, ~45–60
minutes total. Scale to the source's breadth, not to a round number.

### 4. Write the kit

Follow `references/output-contract.md` exactly — the `interviewer` skill parses
these structures, so headings, IDs, and field labels are load-bearing.

```
<kit-name>/
  kit.md          manifest, levels, thresholds, scope, provenance
  rules.md        references/rules-boilerplate.md verbatim + topic-specific rules
  questions.md    the bank and the answer key
  evaluation.md   references/evaluation-template.md verbatim + topic-specific notes
  livecode/       starter, hidden tests, reference solution (if the kit has a segment)
```

`rules.md` and `evaluation.md` are **copied verbatim** and then extended with a
topic-specific section. Do not edit the boilerplate rules or the scoring
formulas per kit — comparability across candidates depends on them being fixed.

Write the topic-specific sections with real content, not placeholders:

- **`rules.md` → `## Topic-specific rules`** — terminology that counts as
  equivalent; misconceptions common enough that the interviewer must mark them
  wrong even when stated confidently; questions where "it depends" is the
  correct answer rather than evasion.
- **`evaluation.md` → `## Topic-specific behavioral notes`** — what hedging
  looks like in this domain, and which domain habits are easily mistaken for
  deviation.

### 5. Verify before delivering

Check and report each of these — do not skip the count:

- [ ] `theory` counted and ≤40% of the bank. State the actual number.
- [ ] Every question has all contract fields; `none` written where empty.
- [ ] IDs unique, zero-padded, correctly leveled.
- [ ] No probe leaks its answer — re-read each one as someone who doesn't know.
- [ ] Point weights sum sensibly and the core insight outweighs the periphery.
- [ ] Every version-dependent fact appears under **Known-unstable areas**.
- [ ] Live coding, if present: reference solution **executed** against the hidden
      tests and passing; starter file leaks no approach; `kit.md` has the
      **Live coding** section; traps named.
- [ ] Provenance table covers every non-obvious claim in the answer key.
- [ ] `rules.md` and `evaluation.md` boilerplate is byte-identical to the
      references.

Then tell the user the kit path, the question count and type ratio, the levels
and gates, what you researched, and — honestly — which areas you are least
confident in.

## Updating an existing kit

Read the current kit first. Preserve existing question IDs; new questions get new
IDs. Never silently renumber — reports from past candidates cite these IDs.

**Refresh the boilerplate whenever the references have moved on.** A kit built
against an older version of `rules-boilerplate.md` or `evaluation-template.md`
is missing rules the interviewer is supposed to be bound by, and tags the report
is supposed to contain. To refresh without losing the kit's own content:

1. Split the kit file at its topic-specific heading (`## Topic-specific rules` /
   `## Topic-specific behavioral notes`) and keep the tail.
2. Rewrite the file as the current reference followed by that tail.
3. Verify the prefix is byte-identical to the reference — the same check as in
   step 5.

Then re-check the kit against the current contract: the type ratio, and whether
a role that writes code is still missing a `livecode` question. Say what you
refreshed and what it changed.
