# RAG (Retrieval-Augmented Generation)

In RAG, the retrieved chunks are usually the **largest** part of every prompt. Tuning retrieval is where most of the savings are.

## The pipeline

```text
Question
→ Metadata filter (service, env, date, team)   ← cheap, cuts the search space
→ Vector / keyword search (candidates)
→ Relevance threshold (drop weak matches)
→ Rerank (keep the best few)
→ Deduplicate
→ LLM with only the top chunks
```

Avoid: `retrieve top-20 → send everything → let the LLM figure it out`.

## Settings that matter

| Setting | Guidance |
|---|---|
| **Top-K** | Start small (3–5). Increase only if answers miss information. Don't always use the max. |
| **Relevance threshold** | Drop low-score chunks — they cost tokens and add noise that makes answers worse. |
| **Chunk size** | Big enough to hold one complete idea (a function, a section, a runbook step). Too small → more chunks needed; too big → paying for irrelevant text. |
| **Chunk overlap** | Keep low. Every overlapping token is paid twice when neighbours are retrieved. Prefer splitting on natural boundaries instead. |
| **Metadata** | Use it to **filter**; send to the LLM only what's needed to cite (source, title). |

## Split on natural boundaries

| Content | Split by |
|---|---|
| Code | function / class |
| Docs, runbooks, Markdown | heading / section |
| Logs | time window or event |
| Tables, tickets, records | one record |

## Reranking

Retrieve ~20 candidates cheaply, rerank, send the top 3–5. A reranker (cross-encoder or a provider rerank API) lets you send fewer chunks for the same answer quality.

## Deduplicate

Docs copied across wikis, repeated runbook boilerplate, near-identical incident reports — remove near-duplicates before the prompt. Duplicates waste tokens and bias the answer toward whatever is repeated.

## Prompt layout (cache-friendly)

```text
[System instructions — fixed]           ← cached
[Output format — fixed]                 ← cached
[Retrieved chunks — change per query]
[User question]
```

## Measure

- **Retrieved vs. used:** how many retrieved chunks does the answer actually rely on? If you retrieve 10 and use 2, lower Top-K or raise the threshold.
- **Tokens per answered question**, not tokens per call.
- Keep a small test set of real questions and re-run it whenever you change chunking, Top-K, threshold, or embedding model.

## Don't use RAG when

- the document is small — just include the relevant part directly;
- the answer needs exact data from a system — query the system (API, SQL, `kubectl`) instead of searching docs about it.

See also: [Embedding Models](08-embeddings.md), [LangChain](09-langchain.md).
