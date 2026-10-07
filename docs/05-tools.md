# 05 · Tools

## 36. Tool Definitions

Tool definitions are part of model context on many agent platforms.

Avoid exposing large tool catalogs when the task needs only a small subset.

Prefer task-relevant tool sets or deferred tool discovery/loading.

## 37. Deferred Tool Loading

When supported, avoid loading every tool schema at the start of a session.

Concept:

```text
Task
→ Discover Relevant Tool
→ Load Tool Definition
→ Invoke Tool
```

This can reduce initial context substantially in systems with large tool catalogs.

## 38. Tool Description Optimization

Tool descriptions should be:

- precise;
- concise;
- non-overlapping;
- explicit about when the tool is appropriate;
- explicit about important limits.

Avoid long prose if a short description provides equivalent routing accuracy.

## 39. Tool Schema Optimization

Audit schemas for:

- unused parameters;
- redundant descriptions;
- duplicated enums;
- deeply nested objects;
- unnecessarily verbose property names;
- unnecessary response fields.

Schema clarity matters, but schema verbosity is recurring token cost.

## 40. Tool Result Optimization

Tools should support:

```text
Filtering
Limits
Pagination
Field Selection
Ranges
Aggregation
Search
```

Large unbounded tool responses are a major context-cost risk.

Use sensible response-size defaults.

## 41. Tool Response Information Density

Measure not only response size but useful information density.

Conceptual metric:

```text
Useful Tool-Result Tokens
─────────────────────────
Total Tool-Result Tokens
```

Low density indicates that filtering, field selection, or summarization should move into the tool layer.

---

Previous: [04 · Context Engineering](04-context-engineering.md) · Next: [06 · Agents & Models](06-agents-and-models.md)
