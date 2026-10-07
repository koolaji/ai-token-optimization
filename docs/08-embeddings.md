# Embedding Models

Embedding calls are cheap per token, but you pay for **every document on every re-index**, and a bad embedding setup forces bigger Top-K (more LLM tokens) to find the right answer.

## Rules

1. **Respect the model's max input length.** Many open-source embedding models accept ~512 tokens; some API models accept several thousand. Text beyond the limit is often **silently truncated** — that part of the chunk is never searchable. Check the model card and size chunks below the limit.
2. **Don't re-embed unchanged content.** Hash each chunk; embed only new or changed ones. Delete vectors for removed docs.
3. **Cache embeddings** for repeated documents and frequent queries.
4. **Batch embedding requests** instead of one call per chunk.
5. **Use the same model for indexing and querying.** Changing the model means re-embedding everything — plan it, don't do it casually.
6. **Clean text before embedding.** Strip HTML, navigation, headers/footers, license banners, repeated boilerplate.
7. **Consider fewer dimensions** where the model supports it (e.g. Matryoshka-style models, or a `dimensions` parameter). Smaller vectors = less storage and faster search, often with little quality loss — measure on your data.
8. **Local models are an option.** Running an open-source embedding model on your own hardware removes per-token cost and keeps data in-house. Compare quality on your own test questions before switching.

## Choosing a model

Test on **your** data, not public leaderboards:

```text
20–50 real questions + the doc that answers each
→ for each candidate model: does the right doc appear in the top 3?
→ pick the cheapest model that meets your target
```

Code-heavy content may need a code-aware embedding model; multilingual content (e.g. Persian + English) needs a multilingual model.

## Embeddings beyond RAG

- **Deduplication:** find near-duplicate docs, tickets, or alerts before sending them to an LLM.
- **Semantic cache:** if a new question is very similar to one already answered, reuse the answer instead of calling the LLM — only for content that doesn't change often, and with a strict similarity threshold.
- **Routing:** classify a request by similarity to examples, instead of calling an LLM to classify it.

See also: [RAG](07-rag.md), [LangChain](09-langchain.md).
