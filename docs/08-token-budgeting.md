# 08 · Token Budgeting

## 60. Token Preflight / Counting

Before sending large requests, estimate or count tokens when provider tooling permits.

Use preflight checks for:

- large retrieved contexts;
- large tool results;
- document processing;
- multi-agent handoffs;
- prompts near context limits.

Concept:

```text
Assemble Candidate Context
→ Count / Estimate Tokens
→ Apply Budget Policy
→ Send
```

## 61. Token Budgeting

Every production AI workflow should have an expected token profile:

```text
Expected Input
Expected Output
Expected Retrieved Context
Expected Tool Context
Maximum Context
Maximum Output
```

## 62. Budget Allocation by Prompt Segment

For large-context workflows, explicitly budget:

```text
System / Skill Instructions
Few-Shot Examples
Conversation State
Retrieved Context
Tool Definitions / Results
Output Reserve
```

The output reserve must be protected; filling the entire context window with input can leave insufficient space for the answer.

## 63. Soft Limits

A soft limit can trigger:

```text
Deduplication
Compression
Reduced Retrieval
Higher Relevance Threshold
Smaller Top-K
Smaller Output
Warning / Escalation
```

before reaching the hard limit.

## 64. Hard Limits

Potential controls:

```text
Maximum Input Tokens
Maximum Output Tokens
Maximum Retrieved Tokens
Maximum Tool-Result Tokens
Maximum Agent Iterations
Maximum Tool Calls
Maximum Retry Tokens
```

## 65. Context Overflow Policy

Define deterministic overflow handling.

Recommended priority:

```text
1. Remove duplicates
2. Remove noise
3. Remove lowest-relevance retrieved chunks
4. Remove optional examples
5. Compress older conversation state
6. Compress large tool results
7. Preserve critical instructions and evidence
8. Fail/escalate rather than silently dropping critical context
```

Avoid arbitrary truncation.

## 66. Token Budget by Task

Categorize workflows:

```text
Tiny
Small
Medium
Large
Exceptional
```

Large/Exceptional workflows should have explicit justification and observability.

---

Previous: [07 · Caching](07-caching.md) · Next: [09 · Retrieval / RAG](09-retrieval.md)
