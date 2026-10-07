# 06 · Agents & Models

## 42. Agent Iterations

Each iteration may add context, tool results, and output.

Unnecessary iterations can multiply total tokens even when each individual call looks reasonable.

## 43. Agent Stop Conditions

Stop when:

```text
Required result obtained
Evidence sufficient
Requested output complete
Token budget reached
Iteration budget reached
Further retrieval has low expected value
```

## 44. Agent Loop Detection

Detect:

```text
Search
Read
Search
Read
Search
Read
```

without meaningful progress.

Also detect repeated calls with effectively identical arguments and results.

## 45. Maximum Agent Iterations

Set budgets according to task complexity.

```text
Simple  → Few
Medium  → Moderate
Complex → Larger but controlled
```

Unlimited loops should not be the default.

## 46. Multi-Agent Token Amplification

Shared context can be multiplied across agents.

```text
20K context × 5 agents
```

may produce far more total processing than a single coordinated workflow.

Pass specialized agents only the context required for their role.

## 47. Agent-to-Agent Communication

Prefer:

```text
Findings
Evidence References
Decision
Open Questions
```

over forwarding complete transcripts, documents, and tool histories.

## 48. Avoid Unnecessary Agents

Do not automatically use researcher → reviewer → critic → verifier → finalizer chains for tasks one model can reliably perform.

Additional agents should provide measurable quality or risk reduction.

## 49. Model Selection

Route tasks to the least expensive/capable model that reliably meets the quality requirement.

```text
Classification     → Lightweight
Extraction         → Lightweight
Standard Q&A       → Standard
Complex Reasoning  → Reasoning Model
High-Risk Analysis → Higher Capability
```

## 50. Model Escalation

Prefer:

```text
Appropriate Model
→ Result insufficient?
→ Escalate
```

over using the highest-cost model for every request.

Measure whether escalation itself creates extra retries that erase savings.

## 51. Reasoning Budget

Not every task requires the same reasoning effort.

Simple extraction should not receive the same reasoning budget as multi-source root-cause analysis.

Where providers expose reasoning-effort controls, tune them by workload and include reasoning tokens in cost/usage accounting.

## 52. Fine-Tuning as Instruction Compression

For stable, high-volume workflows, fine-tuning may reduce the need for long recurring instructions or many few-shot examples.

Consider it only when:

- behavior is stable;
- request volume is high enough;
- evaluation data exists;
- the reduction in recurring prompt size justifies training/maintenance cost;
- governance permits it.

Fine-tuning should be evaluated against Skills, prompt caching, and retrieval rather than assumed to be cheaper.

---

Previous: [05 · Tools](05-tools.md) · Next: [07 · Caching](07-caching.md)
