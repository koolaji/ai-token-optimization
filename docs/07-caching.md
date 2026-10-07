# 07 · Caching

## 53. Caching

Potential reusable content:

```text
System Instructions
Skills
Stable Policies
Tool Definitions
Reference Material
Stable Conversation Prefixes
```

Caching reduces repeated computation/cost where provider support exists.

## 54. Cache-Prefix Architecture

Design prompts as:

```text
Stable Prefix
+
Semi-Stable Context
+
Dynamic Request
```

Place frequently changing content later when provider caching is prefix-based.

Stable content can include:

- global instructions;
- stable Skill instructions;
- stable tool definitions;
- reusable reference material.

Dynamic content can include:

- current user request;
- current retrieval results;
- timestamps;
- volatile state.

## 55. Cache Breakpoints

Where explicit cache breakpoints are supported:

- place breakpoints after stable reusable content;
- avoid caching volatile suffixes with low reuse probability;
- benchmark write cost versus future cache-read savings;
- select breakpoints according to real reuse patterns.

Caching everything is not automatically optimal.

## 56. Cache-Friendly Prompt Design

Avoid unnecessary changes to stable prefixes:

- instruction ordering;
- tool ordering;
- tool schemas;
- static wording;
- static examples;
- stable references.

A semantically equivalent change can still reduce cache reuse if it changes the token prefix.

## 57. Cache vs Compression Tradeoff

Two optimizations can conflict.

Example:

```text
Aggressive conversation compaction
→ fewer raw tokens
→ changed prefix
→ potentially lower cache reuse
```

Therefore evaluate total cost, not only raw prompt length.

## 58. Cache Prewarming

Where supported and economically justified, reusable stable context may be preprocessed before an interactive request to reduce user-visible latency.

Use only when the probability of reuse justifies the cache write.

## 59. Cache Observability

Track:

```text
Cache Read Tokens
Cache Write Tokens
Uncached Input Tokens
Cache Hit Rate
Cache Miss Rate
Reusable Prefix Size
```

Investigate sudden cache-hit degradation after prompt, tool, schema, or configuration changes.

---

Previous: [06 · Agents & Models](06-agents-and-models.md) · Next: [08 · Token Budgeting](08-token-budgeting.md)
