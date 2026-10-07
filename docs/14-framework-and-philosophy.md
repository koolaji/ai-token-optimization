# 14 · Framework & Philosophy

## 121. Optimization Framework

A company standard can organize controls into:

```text
1. Prompt Optimization
2. Skill Optimization
3. Context Optimization
4. Retrieval Optimization
5. Tool Definition Optimization
6. Tool Result Optimization
7. Agent Optimization
8. Model / Reasoning Optimization
9. Output Optimization
10. Cache Optimization
11. Token Budgeting
12. Measurement & Governance
```

## 122. Golden Rules

```text
Search before Retrieve

Filter before Context

Aggregate before Context

Deduplicate before Context

Retrieve before Loading Everything

Reference before Repeating

Cache before Recomputing

Measure Cache Reuse before Rewriting Stable Prefixes

Skill before Repeated Instructions

Focused Skill before Giant Skill

Small Context before Large Context

Relevant Tool Set before All Tools

Bounded Tool Result before Unbounded Result

Appropriate Model before Largest Model

Appropriate Reasoning before Maximum Reasoning

Structured Output before Verbose Output

Progressive Retrieval before "Just in Case"

Stop when Sufficient

Count before Oversized Requests

Measure before Optimizing
```

## 123. Central Philosophy

Token optimization is not:

```text
Make every prompt tiny.
```

It is:

```text
Give the model exactly the information,
instructions, tools, and output budget required
to complete the task successfully —
without paying repeatedly for information
that adds no meaningful value.
```

A useful conceptual target is:

```text
              Required Quality × Success Rate
Efficiency = ─────────────────────────────────
                Tokens × Cost × Latency
```

The exact metric can vary.

The engineering philosophy remains:

```text
MINIMUM NECESSARY INSTRUCTIONS
+
MINIMUM NECESSARY CONTEXT
+
MINIMUM NECESSARY TOOL SURFACE
+
MINIMUM NECESSARY REASONING
+
MINIMUM NECESSARY OUTPUT
=
TOKEN-EFFICIENT AI
```

---

Previous: [13 · Checklists & Anti-Patterns](13-checklists.md) · Next: [Research Notes & Sources](research-notes.md)
