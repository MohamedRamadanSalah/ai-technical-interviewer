# AI Technical Interviewer

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
![Claude Code](https://img.shields.io/badge/Claude%20Code-skills-D97757)

Two [Claude Code](https://claude.com/claude-code) skills that run **strict, unbiased, scored
technical interviews**: one builds a research-backed interview kit from your notes, the other
conducts the interview live (including live coding) and writes a measured report.

They are separate because they run at different times, for different people: the builder runs once
per topic, the interviewer runs once per candidate.

```
  source.md  ──▶  interview-builder  ──▶  kit/  ──▶  interviewer  ──▶  report.md
                  (research + write)      │        (conduct + score)      │
                                          └──────▶  md-to-pdf  ◀──────────┘
                                                    (print + verify)
```

## Install

```bash
git clone https://github.com/MohamedRamadanSalah/ai-technical-interviewer
cd ai-technical-interviewer
claude          # both skills in .claude/skills/ load automatically
```

To use them in every project, copy `.claude/skills/interviewer` and
`.claude/skills/interview-builder` into `~/.claude/skills/`.

For PDF export, also install [md-to-pdf-verified](https://github.com/MohamedRamadanSalah/md-to-pdf-verified)
(see [Printing kits and reports](#printing-kits-and-reports)).

## Usage

```
# build a kit
Use the interview-builder skill on ./my-topic.md, targeting a mid-level backend role.

# run an interview
Use the interviewer skill with the kit at ./kits/my-topic.
```

Both also trigger from a plain description, like "generate interview questions from these notes"
or "interview me on this kit".

## `interview-builder`

Reads a source `.md`, researches the topic, and writes an **interview kit**:

| File | Contents |
|---|---|
| `kit.md` | Manifest: levels, pass thresholds, scope, research provenance, version-unstable areas |
| `rules.md` | The conduct rules binding the interviewer, plus topic-specific rules |
| `questions.md` | The question bank **and the answer key**: key points, model answers, red flags, probes, scoring anchors |
| `livecode/` | Starter file, hidden tests and reference solution, when the kit has a live-coding segment |
| `evaluation.md` | Tag set, scoring formulas, personality rubric, report schema |

Design constraints it enforces:

- **`theory` capped at 40%** of the bank. At least 60% is scenario, practical, debug, tradeoff or
  livecode questions, built on real constraints and real numbers.
- **The discrimination test**: every question must be one that a well-read candidate who has never
  done the work will visibly fail.
- **Probes must not leak** the answer.
- **Acceptable variants** are listed, so a correct but unfamiliar approach isn't marked wrong.

## `interviewer`

Reads a kit and conducts the interview live, then writes a scored report.

- **Unbiased.** It never reveals, confirms or hints at an answer. It never rephrases a question
  that's landing badly, never completes or repairs an answer, and never gives mid-interview
  feedback. It scores what was said, not what was probably meant. Confidence earns nothing.
- **Interactive.** One question at a time, then it reacts to the actual answer: probing claims,
  quoting the candidate back to themselves, and holding them to the question when they drift.
- **Live coding.** Any kit for a role that writes code includes a `livecode` task. The candidate
  writes real code in a real file against a time budget, runs it as often as they like, and
  submits whatever exists when time is up. The interviewer **never writes, edits or fixes a single
  character of it**, runs the file exactly as written, and pastes the output verbatim. Hidden tests
  run once, after submission.
- **Measured, not judged.** Every answer is tagged the moment it ends (`DIRECT` / `PARTIAL` /
  `DEVIATED` / `OFFTOPIC` / `NOANSWER`, plus modifiers like `BLUFF`, `TANGENT`, `RAMBLE`, `HINT`,
  `SELFCORR`; in live coding, `CLARIFIED`, `SELFTEST`, `HAPPYPATH`, `RUNFAIL`, `STUCK`). Every
  percentage in the report is computed from those counts.

Reported metrics include the **Deviation Index** (going around the question instead of answering
it), **Distraction Index**, **Hint Dependency**, **Intellectual Honesty**, **Composure Δ**, and six
personality traits. Each trait needs at least two cited question IDs, or it's reported as
`insufficient evidence` instead of a number.

## Printing kits and reports

PDF export is handled by the separate
[md-to-pdf-verified](https://github.com/MohamedRamadanSalah/md-to-pdf-verified) skill. Install it
next to these skills:

```bash
git clone https://github.com/MohamedRamadanSalah/md-to-pdf-verified .claude/skills/md-to-pdf
python -m pip install -r .claude/skills/md-to-pdf/requirements.txt
python -m playwright install chromium

python .claude/skills/md-to-pdf/scripts/md2pdf.py kits/my-kit/questions.md               # answer key
python .claude/skills/md-to-pdf/scripts/md2pdf.py kits/my-kit/questions.md -a candidate  # redacted
```

The audience goes in the filename, so the answer key can't be handed to a candidate by accident.
Redaction is an allowlist, and every PDF is read back to prove the answer key is absent.

## Example

[`example/`](example) holds a source document and an abbreviated 6-question kit built from it on
**PostgreSQL query performance and indexing** (five spoken questions plus a live-coding task), with
its rendered PDFs. It shows every contract field filled in with real content. Two limits are stated
in its `kit.md`: it was built without web research, and its live-coding task is `review-only`.

## Why the split matters

The kit is the audit trail. Because questions carry weighted key points and fixed scoring formulas,
two candidates who take the same kit are compared on the same basis, and any score in a report can
be traced back to a tag, a quote and a question ID.

## License

[MIT](LICENSE) © 2026 Mohamed Ramadan
