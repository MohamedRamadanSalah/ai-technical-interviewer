# Evaluation Model

Every number in the final report is **computed from counted observations**, never
estimated. If you cannot point to the tags a percentage came from, you may not
report that percentage — report `insufficient evidence` instead.

---

## 1. Observation tags

Tag every answer the moment it finishes, before asking the next question.
Exactly **one primary tag**, plus **zero or more modifiers**.

### Primary (choose one)

| Tag | Meaning |
|---|---|
| `DIRECT` | Answered the question that was asked, on point. |
| `PARTIAL` | On topic and correct as far as it goes, but incomplete. |
| `DEVIATED` | Talked *around* the question — adjacent, plausible-sounding content that never lands on what was asked. |
| `OFFTOPIC` | Unrelated to the question. |
| `NOANSWER` | Declined, said "I don't know", went silent, or ran out of time with nothing usable. |

`DEVIATED` is the key judgment. Test: **strike the answer's text and re-read the
question — is the question still unanswered?** If yes, it is `DEVIATED`, no
matter how fluent or knowledgeable the text sounded.

### Modifiers (any number)

| Tag | Trigger |
|---|---|
| `BLUFF` | Stated something false with confidence, or invented a term/API/fact. |
| `HONEST` | Explicitly and accurately flagged the limits of their own knowledge. |
| `HINT` | Asked for a hint, or asked the interviewer to confirm/deny mid-answer. |
| `PROBED` | Reached the answer only after a probe was used. |
| `RAMBLE` | Exceeded ~2× the question's time budget, or repeated the same point 3+ times. |
| `TANGENT` | Introduced an unrelated subject mid-answer. |
| `RESTATE` | Asked for the question to be repeated or re-explained. |
| `SELFCORR` | Caught and corrected their own error without being prompted. |
| `REDFLAG` | Hit one of the question's listed **Red flags**. |

### Live-coding modifiers (`livecode` questions only)

| Tag | Trigger |
|---|---|
| `CLARIFIED` | Asked a sensible clarifying question before writing code. |
| `NOCLARIFY` | Started coding past a genuinely ambiguous point without asking. |
| `SELFTEST` | Tested their own code against cases they chose, unprompted, before declaring done. |
| `HAPPYPATH` | Declared done having only ever exercised the ordinary case. |
| `RUNFAIL` | At least one failed run before the first successful one. Boolean — actual counts go in the notes entry. |
| `STUCK` | No visible progress for more than a third of the budget. |

---

## 2. Knowledge scoring

**Per question.** Award each *Expected key point* the candidate actually
covered; score is earned weight over total weight:

```
Sq = 100 * (Σ earned point weights) / (Σ all point weights)
```

For a `livecode` question, the *Requirements* are the key points, coverage is
decided by the hidden tests in `runnable` mode, and a **craft adjustment** of up
to ±15 from the question's craft rubric is applied to `Sq` **before** the caps.
Craft never rescues code that does not work.

Then apply the caps, in order — caps only ever lower the score:

- `livecode` in `runnable` mode that never executed successfully → `Sq = min(Sq, 30)`
- `REDFLAG` present → `Sq = min(Sq, 40)`
- `BLUFF` present → `Sq = min(Sq, 30)`
- `PROBED` present → `Sq = min(Sq, 70)`
- `HINT` present → `Sq = min(Sq, 50)`
- `NOANSWER` → `Sq = 0`

Sanity-check `Sq` against the question's **Scoring anchors**. If the computed
number and the anchor disagree by more than 20 points, the key points were
mis-awarded — recount rather than overriding.

**Per level.** Weighted by each question's `weight`:

```
Level score = Σ(Sq × weight) / Σ(weight)
```

**Overall.** Weighted mean of level scores over all questions asked, using the
same question weights. A level that was never reached is excluded from the
overall and reported as `not reached`, never as 0.

**Gate decision.** A level passes when `Level score ≥ Pass threshold` from
`kit.md`. Failing a gated level ends the interview at that level — say so
neutrally, complete the report, and do not continue to easier ground to
"give them a chance".

---

## 3. Behavioral percentages

`N` = number of questions actually asked. All formulas are over `N`; all results
round to the nearest whole percent.

| Metric | Formula | Reading |
|---|---|---|
| **Directness** | `100 × (DIRECT + 0.5 × PARTIAL) / N` | Higher is better. |
| **Deviation Index** | `100 × (DEVIATED + OFFTOPIC) / N` | Lower is better. This is "went around the question instead of answering it". |
| **Distraction Index** | `100 × (answers carrying ≥1 of TANGENT, RAMBLE, RESTATE) / N` | Lower is better. Counts *answers*, not tags — one answer with all three still counts once. |
| **Hint Dependency** | `100 × (HINT + 0.5 × PROBED) / N` | Lower is better. |
| **Self-Correction Rate** | `100 × SELFCORR / N` | Higher is better. |
| **Intellectual Honesty** | `100 × (HONEST + NOANSWER) / U`, where `U = HONEST + NOANSWER + BLUFF` | Report `n/a — no uncertainty encountered` when `U = 0`. |
| **Composure Δ** | `Directness(final third) − Directness(first third)`, in percentage points | Signed. Negative = degraded under accumulating pressure. Report `n/a` when `N < 6`. |

---

## 4. Personality assessment

Six traits, each 0–100. **Every trait must cite at least two question IDs as
evidence.** A trait with fewer than two supporting observations is reported as
`insufficient evidence`, not as a number — an unsupported percentage is worse
than a gap.

| Trait | Derived from |
|---|---|
| **Analytical rigor** | Mean `Sq` on `scenario` / `debug` / `tradeoff` / `livecode` questions; whether answers named constraints and tradeoffs unprompted. |
| **Communication clarity** | `100 − Distraction Index`, adjusted ±15 for whether answers matched the question's **Answer shape**. |
| **Intellectual honesty** | The Intellectual Honesty metric, adjusted down 20 for any `BLUFF` that was defended after a probe. |
| **Ownership** | How errors were handled: `SELFCORR` and plain acknowledgment raise it; deflecting to tools, teammates, or "that's not really how it works in practice" lower it. |
| **Pressure resilience** | `Composure Δ` mapped to 0–100 (`50 + Δ`, clamped), plus whether answer quality held on the hardest questions attempted. |
| **Depth of curiosity** | Frequency of correct, relevant detail *beyond* the Expected key points. Volume alone does not count — only accurate additions do. |

### Live coding: counts, not percentages

A kit usually has one live-coding question, so a percentage over it would be
noise. Report these as **counts and a rating with cited evidence**, never as a
percentage:

- **Code craft** — the craft rubric's verdict, with the adjustment applied and
  its one-line justification.
- **Test discipline** — `SELFTEST` or `HAPPYPATH`, quoted from what they
  actually ran, plus the run counts.
- **Requirement coverage** — met / total, by requirement, with weights.

With two or more live-coding questions these may be averaged; below that, the
`insufficient evidence` discipline in this section applies as everywhere else.

---

## 5. Confidence band

Small samples produce unstable percentages. State the band explicitly:

| N | Band |
|---|---|
| ≥ 15 | High — percentages are meaningful. |
| 8–14 | Moderate — treat as ±10pp. |
| < 8 | **Low — report the counts, and label every percentage indicative only.** |

---

## 6. Report schema

The final report file follows this exact structure:

```markdown
# Interview Report — <Candidate ref> — <Topic>

- **Date:** <YYYY-MM-DD>  · **Kit:** <kit id>  · **Duration:** <mins>
- **Questions asked:** <N>  · **Confidence band:** <High|Moderate|Low>

## Verdict

**<PASS | PASS WITH RESERVATIONS | FAIL>** at **<highest level passed>**.
<Two to four sentences. Evidence only. No encouragement, no consolation.>

## Level results

| Level | Score | Threshold | Result |
|---|---|---|---|

## Knowledge breakdown

| ID | Type | W | Score | Primary tag | Modifiers | One-line basis |
|---|---|---|---|---|---|---|

## Behavioral percentages

| Metric | Value | Counts behind it |
|---|---|---|

## Live coding

**Task:** <Q-LC id>  ·  **Mode:** <runnable|review-only>  ·  **Submitted at:** <mins> of <budget>

| Requirement | W | Met | Basis |
|---|---|---|---|

- **Requirement score:** <n>  ·  **Craft adjustment:** <±n — one-line reason>  ·  **Caps applied:** <which, or none>
- **Final `Sq`:** <n>
- **Runs:** <n failed, n ok>  ·  **Tags:** <CLARIFIED/SELFTEST/HAPPYPATH/RUNFAIL/STUCK>
- **Hidden tests:** <passed>/<total>
- **Post-submission probes:** <what they said their code's weakness was, verbatim>

Omit this section entirely when the kit has no live-coding segment.

## Personality assessment

| Trait | % | Evidence (question IDs) |
|---|---|---|

## Red flags

<Each one, with the question ID and what was actually said. Or `None observed`.>

## Gaps to close before re-interview

<Specific, tied to missed key points. Or `n/a` on a clear pass.>
```

Deliver the report **after** the interview ends, as a file. Nothing in this
document is shared with the candidate during the interview.
