# 11 · Compression & Token-Aware Behavior

## 81. Information Density

Optimize for useful information per token, not merely total token count.

Conceptual metric:

```text
Task-Relevant Information
─────────────────────────
Input Tokens
```

High token count can be justified if information density is high and required for task success.

## 82. Compression Strategy

When reducing context:

```text
1. Deduplicate
2. Remove irrelevant material
3. Remove low-priority material
4. Compress old conversation
5. Compress tool results
6. Reduce retrieval breadth
7. Preserve critical evidence
```

Do not blindly truncate from one side.

## 83. Compression Risk

Summarization/compression can:

- lose edge cases;
- remove uncertainty;
- remove provenance;
- distort numeric values;
- hide conflicts;
- reduce cache reuse.

Use structured summaries and retain references to source material for re-expansion.

## 84. Hierarchical Summarization

For genuinely global large-document tasks:

```text
Chunks
→ Chunk Summaries
→ Section Summaries
→ Final Synthesis
```

Use only when global understanding is required; it adds inference calls and can introduce information loss.

## 85. Token-Aware Agents

Agents should conceptually track:

```text
Budget
Current Usage
Remaining Budget
Expected Next-Step Cost
```

and adapt retrieval/output behavior accordingly.

## 86. Budget-Aware Retrieval

When approaching budget:

```text
Increase relevance threshold
Reduce Top-K
Request narrower tool results
Compress previous context
Avoid optional validation
```

Do not wait until the context window is exhausted.

## 87. Token-Aware Tool Calls

Estimate likely result size before calling a tool.

Prefer bounded requests:

```text
search(query, limit=10)
```

over unbounded retrieval.

## 88. Token-Aware Error Handling

On tool failure, retry with minimum necessary state.

Do not resend giant contexts unless the retry genuinely requires them.

## 89. Token-Aware Retries

Retries can silently multiply usage.

Track:

```text
Original Call
Retry Count
Tokens per Retry
Reason for Retry
```

Set retry budgets and avoid identical repeated calls.

## 90. Token-Aware Validation

Additional model validation should depend on risk.

Use extra verification when:

```text
Risk High
Confidence Low
Task Critical
Result Ambiguous
```

Do not automatically double every request with a reviewer call.

## 91. Expensive Self-Reflection

Patterns such as:

```text
Generate
→ Critique
→ Rewrite
→ Critique
→ Rewrite
```

can multiply tokens.

Use them only when evaluations show sufficient quality improvement.

## 92. Reasoning Transcript Requests

Do not request long reasoning transcripts.

When explanation is required, ask for:

```text
Answer
Evidence
Concise Rationale
```

## 93. Repeated Summarization

Avoid summary-of-summary chains unless each stage has a clear function.

Repeated lossy compression can remove important information while still consuming tokens.

## 94. Large Document Processing

Prefer:

```text
Document
→ Index/Search
→ Relevant Sections
→ LLM
```

over automatically inserting the whole document.

Use full-context processing only when the task truly requires global understanding and the quality/cost tradeoff is justified.

## 95. Formatting Cost

Formatting consumes tokens too.

For machine workflows, avoid unnecessary:

- headings;
- repeated labels;
- decorative Markdown;
- verbose tables;
- prose transitions.

Human-facing documents can prioritize readability instead.

## 96. Compact Internal Representations

Agent-to-agent messages may use compact forms when unambiguous.

Example:

```text
severity=high
component=auth
cause=expired_cert
action=rotate_cert
```

Do not sacrifice clarity merely to save a handful of tokens.

## 97. Request Consolidation

Multiple sequential LLM calls can create repeated prompt overhead.

Where tasks are tightly related and can be reliably handled together, consider combining them into one request with structured output.

However, do not combine unrelated tasks merely to reduce call count; large mixed prompts can hurt quality and cache behavior.

## 98. Parallelism vs Token Cost

Parallel agent/model calls may improve latency but multiply token consumption.

Measure both:

```text
Wall-Clock Latency
Total Tokens Across All Parallel Calls
```

A faster workflow can still be substantially more expensive.

---

Previous: [10 · Instructions & Templates](10-instructions-and-templates.md) · Next: [12 · Measurement & Governance](12-measurement-and-governance.md)
