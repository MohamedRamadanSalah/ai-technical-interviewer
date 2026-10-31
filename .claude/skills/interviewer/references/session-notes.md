# Session Notes

Keep a working notes file for the entire interview, at
`<kit>/sessions/<candidate-ref>-<YYYY-MM-DD>.md`. **Append to it after every
single answer, before asking the next question.**

This file is the reason the report is defensible. Tags written at the end of a
session are reconstructions, and reconstructions bend toward whatever overall
impression formed along the way — which is exactly the bias the kit exists to
prevent.

## Format

```markdown
# Session — <candidate ref> — <kit id>
Started: <HH:MM>  ·  Level order: L1 → L2 → L3

## Q-L1-01
- **Primary:** DIRECT
- **Modifiers:** SELFCORR
- **Key points earned:** 1 [3], 2 [2]  ·  missed: 3 [1]
- **Sq:** 83
- **Quote:** "<verbatim, whenever REDFLAG, BLUFF, or a scoring judgment call>"
- **Note:** <one line — the basis for the tag, not a summary of the answer>
- **Probes used:** none
- **Time:** 3m / 4m budget

## Q-L1-02
...

## Q-LC-01
- **Primary:** PARTIAL
- **Modifiers:** CLARIFIED, RUNFAIL, HAPPYPATH
- **Requirements met:** 1 [4], 3 [2]  ·  missed: 2 [3], 4 [2], 5 [1]
- **Requirement score:** 50  ·  **Craft:** −5 (single 40-line function, name `x` for the accumulator)  ·  **Caps:** none
- **Sq:** 45
- **Runs:** 3 failed, 2 ok  ·  **Submitted at:** 22m of 25m
- **Hidden tests:** 4/9 passed
- **Quote:** "I think that covers everything." — said with the empty-input case untested
- **Note:** asked one good clarifying question up front; never tested a boundary case

## Running tallies
DIRECT 4 · PARTIAL 2 · DEVIATED 1 · OFFTOPIC 0 · NOANSWER 0 · N=7
BLUFF 1 · HONEST 2 · HINT 0 · PROBED 3 · RAMBLE 1 · TANGENT 1 · RESTATE 0 · SELFCORR 1 · REDFLAG 1
Livecode: CLARIFIED 1 · NOCLARIFY 0 · SELFTEST 0 · HAPPYPATH 1 · RUNFAIL 1 · STUCK 0
```

Update **Running tallies** as you go. At the end they are the counts every
percentage is computed from — the report's "Counts behind it" column is a direct
transcription, not a re-derivation.

## Tagging discipline

- **Tag before the next question.** Not at the level boundary, not at the end.
- **One primary tag.** When torn between `PARTIAL` and `DEVIATED`, apply the
  strike test from `evaluation.md`: remove the answer text, re-read the question
  — still unanswered means `DEVIATED`.
- **Never revise an earlier tag because of a later impression.** A strong finish
  does not retroactively improve question 3. Revise a tag only to fix a plain
  recording error, and note that you did.
- **Quote before you judge.** For any `REDFLAG` or `BLUFF`, write the verbatim
  words first, then the tag. If you cannot quote it, you cannot claim it.
- **Award key points explicitly, by number.** "Earned 1 and 3, missed 2" — never
  a holistic score. The per-question score falls out of the awards.
- **On live coding, record the run counts as they happen.** Reconstructing "how
  many times did it fail" at the end is guesswork, and `RUNFAIL` plus the counts
  are among the most telling observations in the session.

## Privacy

The notes file is operator-facing, exactly like the answer key. It is never
shown, summarised, or quoted to the candidate during the session — including
when they ask how they are doing.
