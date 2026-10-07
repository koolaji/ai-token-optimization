# 13 · Checklists & Anti-Patterns

## 115. Input Token Optimization Checklist

- [ ] remove duplicated instructions;
- [ ] remove irrelevant context;
- [ ] compress old state;
- [ ] retrieve smaller relevant chunks;
- [ ] filter before retrieval;
- [ ] aggregate repetition;
- [ ] use focused Skills;
- [ ] reduce unnecessary tool definitions;
- [ ] simplify schemas;
- [ ] prune few-shot examples;
- [ ] preserve cache-friendly stable prefixes;
- [ ] count tokens before oversized requests.

## 116. Output Token Optimization Checklist

- [ ] define output contract;
- [ ] set expected length;
- [ ] return only consumed fields;
- [ ] avoid repeating input;
- [ ] avoid redundant summaries;
- [ ] separate human and machine output;
- [ ] use compact structured output where appropriate;
- [ ] avoid unsolicited tutorials/background.

## 117. Cached Token Optimization Checklist

- [ ] identify reusable prefixes;
- [ ] keep stable content stable;
- [ ] put volatile content later;
- [ ] preserve tool ordering/schema when possible;
- [ ] use explicit cache boundaries where supported;
- [ ] measure cache reads/writes;
- [ ] investigate cache misses;
- [ ] balance compaction against cache reuse.

## 118. Retrieval Token Optimization Checklist

- [ ] metadata filter first;
- [ ] tune Top-K;
- [ ] use relevance thresholds;
- [ ] rerank;
- [ ] deduplicate;
- [ ] reduce chunk overlap;
- [ ] retrieve progressively;
- [ ] include only useful metadata;
- [ ] measure retrieved-to-used ratio.

## 119. Agent Token Optimization Checklist

- [ ] set iteration budget;
- [ ] set retry budget;
- [ ] set tool-call budget;
- [ ] stop when sufficient;
- [ ] detect loops;
- [ ] avoid unnecessary agents;
- [ ] compress handoffs;
- [ ] share references rather than raw context;
- [ ] validate selectively based on risk.

## 120. Token Optimization Anti-Patterns

Avoid:

```text
Entire repository → LLM
Entire documentation set → LLM
Entire conversation → LLM
Every Skill → LLM
Every tool definition → LLM
Every search result → LLM
Huge tool result → LLM
Huge model output → another agent
Largest model → every task
Maximum reasoning → every task
Unlimited retries
Unlimited agent loops
Repeated context
Repeated instructions
Repeated examples
"Just in case" retrieval
Automatic reviewer agents
Blind truncation
Caching without reuse analysis
Compression without information-loss analysis
```

---

Previous: [12 · Measurement & Governance](12-measurement-and-governance.md) · Next: [14 · Framework & Philosophy](14-framework-and-philosophy.md)
