# 09 · Retrieval / RAG

## 67. Retrieval / RAG Token Optimization

Control:

```text
Chunk Size
Chunk Overlap
Top-K
Relevance Threshold
Metadata Filters
Reranking
Deduplication
Freshness
```

Do not use one fixed retrieval configuration for every task.

## 68. Dynamic Top-K

Simple questions should retrieve fewer chunks.

Complex tasks may progressively retrieve additional chunks.

Avoid always retrieving the configured maximum.

## 69. Relevance Thresholds

Discard low-quality matches before prompt assembly.

Low-relevance chunks cost tokens and can reduce answer quality by adding noise.

## 70. Reranking

```text
Search
→ Candidate Set
→ Rerank
→ Top Relevant Context
→ LLM
```

Reranking can reduce the amount of context required for equivalent answer quality.

## 71. Chunk Overlap

Excessive overlap duplicates tokens.

Prefer semantic boundaries where possible:

- functions/classes for code;
- headings/sections for documentation;
- events/windows for logs;
- logical records for structured data.

## 72. Context Ordering

Use clear and consistent organization.

Possible structure:

```text
Task
Constraints
Critical Evidence
Supporting Evidence
Output Contract
```

Ordering should be validated with evaluations rather than based only on intuition.

## 73. Metadata Efficiency

Metadata helps grounding but also costs tokens.

Include only metadata that affects reasoning, provenance, filtering, or citation.

Avoid attaching large metadata objects to every retrieved chunk.

## 74. "Just in Case" Context

A major anti-pattern:

```text
Include this too, just in case.
```

Repeated across multiple sources, this produces large prompts with low information density.

Prefer progressive retrieval.

## 75. Avoid the "Everything Agent"

An agent should not automatically load:

```text
All company documentation
All Skills
All tools
All repositories
All conversation history
```

Context should be assembled per task.

---

Previous: [08 · Token Budgeting](08-token-budgeting.md) · Next: [10 · Instructions & Templates](10-instructions-and-templates.md)
