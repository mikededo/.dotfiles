---
name: devils-advocate
description: Debate the current task against an adversary agent that argues against your plan or implementation, so weak and costly choices surface before you build on them.
disable-model-invocation: true
---

Guardiola's rule: always keep someone against you. Run a short, focused debate between you (the orchestrator, who holds the position) and a **devil's advocate** subagent (who attacks it). Agents agree too easily. The value of this skill is the friction, so neither side gives ground without a reason.

## 1. State the position

Write down what you are about to do, or what you already did, for the current task. Number each decision and give it a one-line rationale:

```text
D1. Use the `muted` token for zebra rows: subtle enough not to compete with the status badges.
D2. Drop the row hover color: the selection checkbox already shows focus.
```

Cover every decision the task depends on, including the ones you consider obvious. Obvious choices are where agreement hides. Stay inside the task's scope; the debate is about this change, not the codebase.

## 2. Launch the devil's advocate

Pick a model from a different family than yours, since a model argues weakly against its own reasoning. In T3 use `delegate_task` with `mode: "wait"`; elsewhere use the harness's subagent tool. Take the target ids and effort from the vault's `workflows/orchestration.md`. The subagent starts with no history, so the brief carries everything: the goal, exact paths, the position, any screenshots or URLs, and the brief in [`ADVOCATE.md`](ADVOCATE.md), passed verbatim.

The advocate only reads. It never edits files.

## 3. Rebut

For each objection, answer one of:

- **Hold**: the decision stands. Give the evidence: a file and line, a measurement, a screenshot, a rule from the repo's docs. "I still think it's fine" is not a rebuttal.
- **Concede**: the advocate is right. Restate its argument in your own words and say what changes. Concede only to an argument you cannot counter, never to end the debate.
- **Counter**: you accept the problem but reject the fix. Propose a different one.

Then start a new advocate round with the **open points**: the position, plus one line per point still in play, written in your own words: the advocate's claim, the evidence it cited, and your answer. Drop conceded points. Paste no raw replies from earlier rounds: a summary keeps the round short and avoids provider blocks on copying model output. A new `delegate_task` per round, never a message to the old thread.

## 4. Stop

Stop when a round moves no point (no new concession from either side), or after 3 rounds. Short beats exhaustive: the user wants friction, not a seminar.

## 5. Report the ledger

```markdown
| #   | Decision            | Advocate's case                  | Outcome  | Deciding evidence                 |
| --- | ------------------- | -------------------------------- | -------- | --------------------------------- |
| D1  | `muted` zebra rows  | invisible on low-end panels      | Changed  | contrast 1.04:1, measured         |
| D2  | No row hover color  | keyboard users lose their place  | Disputed | -                                 |
| A1  | (new) Sticky header | long tables lose column names    | Held     | rows capped at 50, `Table.tsx:88` |
```

Outcome is **Held**, **Changed**, or **Disputed**. Then, in at most three lines, say which disputed point matters most and why. The user referees the disputed points.

Do not apply the changes yet. Wait for the user's call, unless they asked you to apply the outcome when they invoked this skill.
