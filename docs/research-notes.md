# Research Notes & Sources

## Research-Backed Additions

The deep-research pass added or strengthened the following areas:

1. **Cache-prefix architecture** — stable content first, volatile content later.
2. **Explicit cache-breakpoint strategy** — cache only reusable prefixes where supported.
3. **Cache vs compaction tradeoff** — shortening context can sometimes reduce cache reuse.
4. **Cache prewarming** — useful for predictable reusable context where supported.
5. **Deferred tool loading** — avoid paying context cost for large unused tool catalogs.
6. **Token preflight/counting** — inspect large requests before model invocation.
7. **Reasoning/tool-use token accounting** — include provider-exposed non-output token categories.
8. **Fine-tuning as instruction compression** — evaluate for stable, high-volume workflows.
9. **Context-overflow policy** — deterministic prioritization instead of blind truncation.
10. **Information-density metrics** — optimize useful information per token.
11. **Agent amplification factor** — expose hidden multi-agent token multiplication.
12. **Request consolidation** — reduce repeated request overhead where tasks naturally belong together.
13. **Parallelism accounting** — latency improvements can conceal increased total token cost.
14. **Tool-result response limits** — filtering, pagination, ranges, and truncation should exist at the tool layer.
15. **Prompt/Skill CI token preflight** — catch static token regressions before production.

## Research Notes

Research was cross-checked against current guidance available on **7 October 2026**.

- **OpenAI — Prompt Caching:** Current guidance emphasizes stable prompt prefixes, preserving tool definitions/order, explicit cache breakpoints on supported models, deferred tool loading, cache prewarming, and cache diagnostics.
- **OpenAI — Prompting:** Treat production prompts as version-controlled application code with tests and evaluation checks.
- **OpenAI — Latency Optimization:** Filtering context, maximizing shared prompt prefixes, fine-tuning for recurring instruction reduction, and consolidating tightly related sequential operations can improve efficiency.
- **Anthropic — Writing Effective Tools for Agents:** Tool responses should use pagination, filtering, range selection, truncation, and sensible defaults to avoid excessive context.
- **Google Gemini — Token Counting / Context Caching:** Token usage should be counted/observed across input, output, cached content, tool use, and reasoning categories where exposed; reusable context can be cached.
- **Microsoft Azure — RAG Prompt Engineering:** Explicit context budgets, top-K tuning, relevance thresholds, de-duplication, overflow handling, and output reservation are central to context management.

## Official References

- [OpenAI — Prompt Caching](https://developers.openai.com/api/docs/guides/prompt-caching)
- [OpenAI — Prompting](https://developers.openai.com/api/docs/guides/prompting)
- [OpenAI — Latency Optimization](https://developers.openai.com/api/docs/guides/latency-optimization)
- [Anthropic — Writing Effective Tools for AI Agents](https://www.anthropic.com/engineering/writing-tools-for-agents)
- [Google Gemini — Token Counting](https://ai.google.dev/gemini-api/docs/tokens)
- [Google Gemini — Caching](https://ai.google.dev/api/caching)
- [Microsoft Azure — RAG Prompt Engineering](https://learn.microsoft.com/en-us/azure/architecture/ai-ml/guide/rag/rag-prompt-engineering)

---

Previous: [14 · Framework & Philosophy](14-framework-and-philosophy.md) · Back to [README](../README.md)
