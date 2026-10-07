# 04 · Context Engineering

## 18. Context Engineering

Prompt engineering controls what is asked.

Context engineering controls what the model sees.

For large AI systems, context engineering can provide larger savings than merely shortening the user prompt.

## 19. Minimum Required Context

Do not provide information because:

```text
"It might be useful."
```

Provide it because:

```text
"It is required or highly relevant
to the current reasoning step."
```

## 20. Context Relevance

Evaluate candidate context for:

```text
Relevance
Freshness
Uniqueness
Authority
Necessity
```

Remove context that is irrelevant, outdated, duplicated, superseded, or low-value.

## 21. Context Priority

Classify context:

```text
Critical
Relevant
Optional
Noise
```

Default to Critical + Relevant.

Retrieve Optional only when necessary.

Never intentionally include Noise.

## 22. Search Before Retrieval

Use:

```text
Search
→ Identify
→ Retrieve
```

rather than:

```text
Retrieve Everything
→ Ask LLM to Search
```

This applies to any external source.

## 23. Filter Before LLM

```text
Raw Data
→ Deterministic Filter
→ Relevant Data
→ LLM
```

Do not use the LLM as an expensive filtering engine when deterministic filtering is reliable.

## 24. Aggregate Before LLM

Repeated data should be aggregated.

Bad:

```text
Error X
Error X
Error X
... 500 times
```

Better:

```text
Error X occurred 500 times.
Representative samples: ...
```

## 25. Deduplicate Context

Remove:

- duplicate chunks;
- near-duplicate search results;
- overlapping chunks;
- repeated errors;
- repeated instructions;
- repeated documentation;
- repeated tool output.

Duplicate context wastes tokens and can bias attention toward repeated information.

## 26. Context Compression

Large context can be transformed into compact state before reuse.

Preserve:

```text
Facts
Decisions
Constraints
Evidence
Open Questions
Identifiers
Current State
```

Compress or remove:

```text
Conversation filler
Repeated explanations
Dead-end exploration
Superseded attempts
```

## 27. Conversation History

Do not assume complete raw history must remain indefinitely.

Compact older history into:

```text
Objective
Current State
Decisions
Constraints
Known Facts
Evidence
Open Questions
```

However, compaction has a tradeoff: changing earlier prompt prefixes can reduce provider-side prompt-cache reuse. The application should balance context compression against cache efficiency.

## 28. Remove Superseded Context

When a requirement changes, retain the authoritative current requirement unless historical evolution is relevant.

Avoid carrying mutually obsolete instructions indefinitely.

## 29. Avoid Repeating Model Output

Do not automatically copy complete previous responses into the next call.

Pass only:

- required findings;
- evidence references;
- decisions;
- unresolved questions;
- state needed for continuation.

## 30. Task Isolation

Unrelated tasks should not inherit unrelated context.

Context lifetime should follow task lifetime, not session lifetime by default.

## 31. Few-Shot Examples

Examples consume tokens.

Use them only when they measurably improve:

- behavior;
- format adherence;
- classification accuracy;
- ambiguity handling;
- edge-case handling.

Prefer one or two representative examples over many repetitive examples when quality is equivalent.

## 32. Few-Shot Pruning

Treat every example as a recurring token expense.

Periodically test removing examples. If quality remains within target, remove them.

## 33. Structured Inputs

Structured inputs can reduce ambiguity and unnecessary prose.

```text
Task: Review
Environment: Production
Scope: Security
Change: ...
```

Use structure where it improves consistency; do not add structure merely for decoration.

## 34. Structured Outputs

Use schemas containing only fields that downstream consumers need.

Every field name, description, enum, and nested structure can add recurring context cost.

## 35. JSON Token Efficiency

Avoid unnecessarily deep or verbose schemas.

Bad:

```json
{
  "analysis": {
    "result": {
      "detailed_information": {
        "status_information": "failed"
      }
    }
  }
}
```

Better when equivalent:

```json
{
  "status": "failed"
}
```

---

Previous: [03 · Skills](03-skills.md) · Next: [05 · Tools](05-tools.md)
