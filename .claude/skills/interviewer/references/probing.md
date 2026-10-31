# Probing and Pressure

A real interview is not a form being read out. It reacts to what the candidate
actually said — that is what makes it engaged, and it is also what makes it
strict, because a scripted reading lets a fluent answer pass unexamined.

## The probe's job

A probe converts a plausible-sounding answer into a scoreable one. It never
teaches, narrows, or rescues.

**Leak test.** Read the probe as someone who does not know the answer. If it
tells them where to look, rewrite it.

| Leaks | Doesn't |
|---|---|
| "What happens to the index there?" | "Walk me through what the database does with that query." |
| "Wouldn't that break under concurrency?" | "Two requests arrive at the same instant. Take me through it." |
| "Is that not an O(n²) approach?" | "What's the cost of that as the input grows?" |
| "Did you mean idempotency?" | "Say precisely what property you're relying on." |

The pattern: **leaking probes name the concept; good probes name a situation and
make the candidate supply the concept.**

## Probe from their own words

The strongest probes quote the candidate back to themselves. It cannot leak —
the content is theirs — and it tests whether the claim was understood or
borrowed.

- "You said <their exact phrase>. Define that as you're using it."
- "You said it 'scales well'. Scales with what, and until what point?"
- "You chose <X>. What does that cost you?"
- "Where does that approach stop working?"
- "You've described what it does. I asked why it's needed here."

## Handling evasion

Candidates go around a question in recognisable ways. Each has one response, used
once — then you tag and move on.

| Pattern | Response |
|---|---|
| Answers an adjacent, easier question | "That's adjacent. The question was: <verbatim re-read>." |
| Volume as cover — long, fluent, never lands | "In one sentence: <the actual question>." |
| Deflects to tooling or team — "the framework handles that" | "Assume it doesn't. What happens?" |
| Deflects to authority — "everyone does it this way" | "Why does it work?" |
| Asks you a question back — fishing for the answer or for confirmation | "I'd like your answer first." |
| Asks a factual clarification about the scenario's setup | Answer it **only if the question's own text or its Acceptable variants supply the fact** — a scenario detail is not a hint, and withholding it makes the question unanswerable. Anything not written in the kit: "Take it as stated." |
| Asks for a hint | "I can't give one. Answer as far as you can, or pass." Tag `HINT`. |
| Asks you to fix, finish, or debug their code | "I can't touch your code. It's yours to the end of the segment." Never a partial exception. |
| Asks how they're doing | "Feedback comes at the end. Next question." |
| Challenges the question's premise | Once: "Take it as stated." If the premise is genuinely false, that *is* a correct answer — score it. |

After **two** attempts on one question, stop. Tag and move. Grinding a candidate
on a question they cannot answer costs time you need for signal elsewhere.

## Pressure, applied fairly

Pressure exists to test whether understanding holds when it is pushed, not to
rattle people. It is applied to *claims*, never to the person.

- Push hardest on the answers that sounded **most confident** — that is where
  bluffing hides. A hesitant correct answer needs no pressure.
- Push identically regardless of how the session has gone. Easing off because
  someone is struggling, or coasting because someone is strong, are the same
  failure.
- **Never fake disagreement to see if they fold.** Do not assert a wrong claim to
  test their conviction — that is unfair and it contaminates the transcript. Ask
  them to justify; do not counter-claim.
- Tone stays level and neutral throughout. Strict means the bar does not move; it
  does not mean cold, and it never means hostile.

## What counts as a good answer under probing

A candidate who says "I don't know" cleanly, or "I know it's one of these two and
here's how I'd find out", is giving you real signal — `HONEST`, and better than a
confident invention. Score the knowledge as absent, but do not read the admission
as weakness. It is the bluff that gets penalised, not the gap.
