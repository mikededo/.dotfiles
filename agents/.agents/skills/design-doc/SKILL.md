---
name: design-doc
description: Writes or updates Linear design documents for the current working issue, including issue context, related work, a concept-level implementation plan, open questions, and decisions. Use when the user asks to write, create, update, revise, or maintain a design doc/spec for a Linear issue, task, project, or current work item.
---

# Linear Design Doc

## Quick Start

Create or update a Linear document attached to the relevant issue or project. Use the Linear MCP tools, not browser automation, when reading issues and saving documents.

If the user did not provide enough Linear context, ask one short question for the missing issue, project, or team. Prefer an issue identifier like `TEAM-123`; otherwise accept project/team names and search Linear.

## Document Shape

Use this structure unless the user asks for a different one:

```md
# Design: [short title]

## Context
[Problem, user/customer need, current behavior, relevant issue/project details, related issues, constraints, and useful codebase/domain context.]

## Proposed Plan
[Concept-level implementation plan. Explain ideas and tradeoffs clearly. Include codebase details only when they help understanding. Avoid step-by-step file edit instructions.]

## Open Questions
- [Question that affects scope, behavior, or implementation]

## Decisions
- [Decision made, with brief rationale]

## Updates
- [Date/context: what changed and why]
```

## Workflow

1. Identify Linear target.
   - If issue ID is provided, call `Linear_get_issue` with relations, customer needs, and releases when useful.
   - If only project/team/current task is mentioned, search with `Linear_list_issues`, `Linear_list_projects`, or `Linear_list_teams`.
   - If ambiguous, ask user to choose. Do not guess between multiple plausible tasks.

2. Gather context.
   - Read issue title, description, state, labels, priority, assignee, project, cycle, relations, customer needs, releases, and attachments when relevant.
   - Read existing comments if they contain decisions, clarifications, or requirements.
   - Inspect codebase only enough to explain domain concepts, affected systems, constraints, and options.

3. Find existing document.
   - Use `Linear_list_documents` filtered by issue or project when possible.
   - Match by title, issue reference, or design-doc content.
   - If multiple likely docs exist, ask which one to update.

4. Create or update document.
   - For a new doc, call `Linear_save_document` with parent issue or project.
   - For an existing doc, call `Linear_get_document`, preserve useful content, then call `Linear_save_document` with updated content.
   - Use a clear title: `Design: [issue identifier] [short issue title]` when creating.

5. Link and summarize.
   - If created under a project instead of issue, ensure the issue references the document when useful by updating the issue description or adding a comment.
   - Tell user which document was created/updated, what changed, and any remaining open questions.

## Update Rules

- Prefer inline edits when new info clarifies existing sections.
- Move answered open questions into `Decisions` when user or issue comments resolve them.
- Add new unknowns to `Open Questions`; remove stale questions only when resolved or irrelevant.
- Add a short `Updates` entry for substantial revisions.
- Preserve prior decisions unless explicitly superseded; if superseded, note why.
- Keep plan at idea/architecture level. Do not produce a coding checklist like "edit file X, add function Y" unless user asks.

## Linear MCP Notes

- Use `Linear_save_document` for create/update. Documents can belong to an issue or project.
- Use Markdown content with literal newlines. Do not escape Markdown.
- Use issue/project mentions naturally when useful, such as `@ISSUE-123` or project names, but do not over-link.
- Linear documents use the same Markdown editor as issues and support headers, lists, code blocks, comments, and references.

## Review Checklist

- Description has clear triggers.
- Target Linear issue/project is unambiguous.
- Context explains why the work exists.
- Plan explains concepts, tradeoffs, and likely system boundaries.
- Open questions are actionable.
- Decisions are separated from assumptions.
- Existing document content was preserved unless intentionally changed.

