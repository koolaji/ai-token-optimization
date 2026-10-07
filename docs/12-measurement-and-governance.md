# 12 · Measurement & Governance

## 99. Prompt/Skill Versioning

Treat prompts and Skills as production code:

- version control;
- code review;
- owners;
- tests;
- release tags;
- rollback;
- evaluation fixtures;
- token baselines;
- changelogs.

## 100. Prompt Regression Testing

Compare prompt versions on:

```text
Quality
Success Rate
Input Tokens
Output Tokens
Reasoning Tokens
Cached Tokens
Tool-Use Tokens
Latency
Cost
```

Example question:

```text
Is +100% token consumption justified
by +1% task quality?
```

## 101. Skill Regression Testing

Benchmark Skill changes using representative workloads.

A Skill change should not be accepted as an optimization solely because its source file is shorter.

Measure end-to-end behavior.

## 102. Representative Evaluation Dataset

Maintain cases such as:

```text
Simple
Medium
Complex
Edge Case
Large Context
Tool Heavy
Ambiguous
Failure / Missing Context
```

Run these against prompt, Skill, model, retrieval, and tool-schema changes.

## 103. Token Preflight Tests in CI

For stable workflows, CI can calculate or estimate prompt sizes before deployment.

Potential checks:

- Skill size regression;
- static instruction growth;
- tool-schema growth;
- few-shot growth;
- expected context budget;
- output schema growth;
- cache-prefix changes.

## 104. Token Efficiency Metrics

Track at minimum:

```text
Input Tokens
Output Tokens
Cached Tokens
Uncached Tokens
Total Tokens
Model
Skill
Workflow
Success / Failure
```

For agents additionally:

```text
Reasoning Tokens where exposed
Tool-Use Tokens where exposed
Iterations
Tool Calls
Retrieved Tokens
Retries
```

## 105. Tokens per Successful Task

```text
Total Tokens
────────────
Successful Tasks
```

This is more meaningful than raw token volume.

A low-token workflow that frequently fails can be less efficient.

## 106. Cost per Successful Task

```text
Total AI Cost
─────────────
Successful Tasks
```

Include retries, subagents, validation calls, and tool-related model calls.

## 107. Input / Output Ratio

```text
Input Tokens
────────────
Output Tokens
```

A very high ratio can indicate excessive context, although some tasks legitimately require large evidence inputs and small outputs.

## 108. Context Utilization

Conceptual metric:

```text
Relevant Context
────────────────
Retrieved Context
```

Example:

```text
30K retrieved tokens
3K materially useful tokens
≈ 10% utilization
```

This suggests retrieval/context-engineering problems.

## 109. Retrieval Efficiency

Track:

```text
Retrieved Tokens / Successful Task
Chunks Retrieved / Task
Chunks Actually Referenced / Task
Re-Retrieval Rate
Duplicate Chunk Rate
```

## 110. Cache Efficiency

Track:

```text
Cached Input / Cache-Eligible Input
Cache Hit Rate
Cache Miss Reason
Cache Write Cost
Cache Read Savings
```

A shorter prompt is not necessarily cheaper if it destroys high-value cache reuse.

## 111. Tool Context Efficiency

Track:

```text
Tool Definition Tokens
Tool Result Tokens
Useful Tool Result Ratio
Tool Calls / Successful Task
Repeated Tool Calls
```

Tool schemas and results should be treated as first-class token consumers.

## 112. Agent Amplification Factor

Useful conceptual metric:

```text
Total Tokens Across Agent Workflow
──────────────────────────────────
Tokens of Primary User Task
```

High amplification may reveal unnecessary subagents, retries, or duplicated context.

## 113. Token Efficiency Score

Possible internal concept:

```text
Quality × Success Rate
──────────────────────
Tokens × Cost × Latency
```

Do not standardize the exact formula until metrics and business priorities are clear.

## 114. Avoid Optimization Without Measurement

Always compare:

```text
Before
vs
After
```

on:

```text
Tokens
Quality
Latency
Cost
Success Rate
Cache Behavior
```

Shorter is not automatically better.

---

Previous: [11 · Compression & Token-Aware Behavior](11-compression-and-token-aware-behavior.md) · Next: [13 · Checklists & Anti-Patterns](13-checklists.md)
