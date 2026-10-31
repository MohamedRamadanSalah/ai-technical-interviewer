# Question Design

The kit's whole job is to **separate people who understand the topic from people
who can talk about it.** Every question must be one someone who has only read
about the subject will visibly fail, and someone who has used it will answer
without effort.

## The discrimination test

Before a question enters the bank, answer this: *what does a strong candidate
say here that a well-read weak candidate cannot?* If the honest answer is
"nothing — they'd both recite the same definition", the question is dead weight.
Cut it or convert it into a scenario.

Definitional questions fail this test almost always. "What is X?" is answerable
from a blog post skim. "Here is a system using X that is failing this way — why?"
is not.

## Question types and the 60% floor

| Type | What it demands |
|---|---|
| `theory` | Recall and explanation of a concept. **Cap at 40% of the bank.** |
| `scenario` | A described situation with constraints; candidate must reason to a decision. |
| `practical` | Produce something concrete — code, a query, a schema, a command, a config, a sequence of steps. |
| `debug` | Given broken behaviour or a symptom, locate the cause and justify the diagnosis. |
| `tradeoff` | Two defensible options; candidate must pick one and pay its cost honestly. |
| `livecode` | Candidate writes working code during the interview, against a time budget. Highest signal, highest time cost — see `livecode-contract.md`. |

**`theory` may be at most 40% of the bank** — so the five applied types together
are at least 60%. This is a hard requirement, not a preference: count the
`theory` questions and check the number before writing the manifest, and record
the actual ratio at the top of `questions.md`.

`tradeoff` questions are where bluffing dies: the model answer is not a side, it
is the *cost the candidate accepts by choosing their side*. A candidate who names
a side and no cost has not answered.

`livecode` is where bluffing dies fastest — code either runs or it doesn't, and
no amount of fluency changes the output. Budget one live-coding task at 20–30
minutes rather than several small ones, and design it around an edge case the
task statement doesn't mention. A kit for any role that writes code should have
one; a kit for a role that doesn't should not.

## Building scenarios that aren't fake

- **Anchor them in the source material.** The scenario's specifics — the scale,
  the data shape, the constraint — should come from the source `.md` and the
  research, so the scenario is one that actually occurs in this domain.
- **Give real numbers and real constraints.** "A lot of traffic" invites waffle;
  "40k writes/sec, 200ms p99 budget, single region" forces a decision.
- **Make the naive answer wrong.** The best scenarios have an obvious answer that
  fails for a stated reason. Candidates who pattern-match give the obvious one;
  candidates who reason notice the constraint that kills it.
- **One decision per question.** If a scenario has three decisions in it, you
  cannot tell which one they got right.

## Levels

Levels are about **depth of understanding, not obscurity of trivia.** A harder
level should not mean rarer facts; it should mean the same facts under more
constraints, with more interaction between them.

| Level | Question of |
|---|---|
| L1 Foundations | Does the mental model exist at all? Can they apply the core concepts to a clean case? |
| L2 Applied | Can they use it under realistic constraints, and diagnose it when it misbehaves? |
| L3 Depth & design | Can they choose between approaches, name what each costs, and design something whole? |

Set pass thresholds so the gate means something — typically 70 / 65 / 60,
descending, because later questions are harder. Say why in `kit.md` if you
deviate.

Use `Depends on:` sparingly, for questions that genuinely cannot be scored if an
earlier one was missed.

## Writing the answer key

- **Expected key points are things the candidate must *say*,** not topics they
  must "cover". Write them as claims, so awarding them is a yes/no judgment, not
  a vibe: not `understands indexing` but `states that the index is unused because
  the predicate wraps the column in a function`.
- **Weight the points** so the load-bearing insight is worth more than the
  surrounding detail. A candidate who gets the periphery and misses the core
  must not score 70%.
- **Red flags are specific false claims**, quoted the way a candidate would say
  them — not "misunderstands the topic". They are what makes the report
  defensible.
- **Acceptable variants matter most on `practical` and `tradeoff` questions.**
  Enumerate the genuinely different correct approaches, or the interviewer will
  mark a correct unfamiliar answer as wrong. This is the single biggest source
  of unfair scoring, and it is the builder's fault when it happens, not the
  interviewer's.
- **Probes must not leak.** Read each probe as if you did not know the answer: if
  it narrows the space toward the answer, rewrite it. `"What happens to the index
  there?"` leaks. `"Walk me through what the database does with that predicate."`
  does not.

## Volatile facts

Anything version-dependent goes in `kit.md` under **Known-unstable areas**, and
the question's **Acceptable variants** must say which versions are accepted. Do
not build a question whose correct answer changed in the last year unless the
question names the version explicitly.
