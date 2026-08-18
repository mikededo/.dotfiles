---
name: test-value
description: Test value gate for writing, updating, deleting, or auditing tests. Invoke whenever writing, changing, reviewing or cleaning tests. Identify a behavior owner, prove distinct regression risk, and justify deletions against keeper coverage.
---

# Test value

## Ownership

Before changing a test, read its assertions, production entry point, non-test callers, sibling tests, and relevant history. State the behavior or independent contract, a credible regression that would fail this test, and the **keeper**: the strongest practical boundary that exercises the real logic. Inputs and outputs of a utility or store are behavior; rendering a component is not automatically stronger, especially if its dependencies are mocked. Keep separate tests for independent risks such as transport, serialization, persistence, timing, accessibility, or vendor compatibility.

## Writing or updating

1. Name the observable outcome and a regression the assertion would catch. For a bug, prove it fails on the old behavior for the intended reason when practical.
2. Check whether an existing keeper already catches that regression. Extend its case rather than replay the same path at another layer. Assert user-visible effects or external contracts, not private call sequences or values computed by the subject under test.
3. Use realistic boundaries and minimal fakes. A mock must not implement the behavior being asserted; a component test that mocks the affected utility is not a replacement for its test. Pin fixture bytes, vendor identities, or request shapes only when those exact values are the contract. Keep tests that protect real edge cases; their number alone is not a code smell.
4. Avoid production exports, flags, wrappers, or injection points needed only by a test. A new test is ready when its failure mode is distinct and its owner is clear.

## Auditing and deleting

Inventory all owned suites, including cases outside the feature folder. Establish pass/fail/blocked baseline **before** judging value; a suite that cannot load is unverified, not low-value. For a subsystem-wide audit, give every declaration (or table row when rows differ) one mark:

- **R — retain:** state the distinct contract and credible regression.
- **F — fix:** retain the contract, repair weak or misleading assertions.
- **C — consolidate:** name the keeper, the assertion to carry over, and the duplication to remove.
- **D — delete:** show the keeper already catches the same failure, or explain why no meaningful contract exists.

For each proposed deletion, record exact test name and location, actual failure it detects, non-test callers of the production seam, named keeper and its assertion (or why no proof is needed), relevant history, production/test-support cleanup unlocked, risk, and focused validation command. An absent keeper, indirect coverage, or blocked baseline means **defer**, not delete. Review failed tests as possible product bugs, not pruning opportunities.

Work one coherent owner boundary at a time. Preserve independent contract cases, remove unused test-only seams if unlocked, and run the keeper plus siblings. For uncertain replacements, temporarily break the relevant production behavior and confirm the keeper goes red; restore the source byte-for-byte. Never claim a whole-subsystem audit if any owned suite or declaration was not inspected; list it as pending instead.

## Handoff

Report the scope and baseline; each removed or consolidated test with its reason and keeper; repaired and retained false positives; validation actually run and blockers; gaps and follow-ups; and production versus test LOC separately. Optimize for confidence, not test-count reduction.
