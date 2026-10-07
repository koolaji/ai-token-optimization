# Building AI Automations

For scripts, bots, and CI jobs that call LLM APIs.

## Request design

- **Fixed output contract.** Ask for JSON with only the fields the code reads:
  ```json
  {"status": "failed", "cause": "config_mismatch", "confidence": 0.9}
  ```
- **Set `max_tokens`** per job type (classification: tiny; review: medium) — not one global value.
- **Filter in code, not in the model.** Use `grep`/`jq`/SQL to select data; send only what remains.
- **Bound tool results.** Every tool you expose should have a limit and filters.

## Caching (big, easy savings)

Providers cache the **beginning** of the prompt. Structure every request as:

```text
[stable instructions + tool definitions]   ← identical every call → cached
[the variable data for this call]          ← changes → put it last
```

- Don't put timestamps, IDs, or per-request data in the stable part.
- Don't reorder or reword the stable part without reason — any change breaks the cache.
- Check the cache-read numbers in the API usage response to confirm it works.

## Model and cost

- Route by task: small model for classification/extraction, bigger only for hard reasoning.
- Lower reasoning effort for simple tasks where the provider allows it.
- Non-urgent bulk jobs (nightly reports, mass log classification): use the provider's **batch API** — typically about half price.

## Limits (always set)

| Limit | Why |
|---|---|
| Max agent iterations | Prevent endless loops |
| Max tool calls | Same |
| Max retries (and don't retry identical requests) | Retries silently multiply cost |
| Max input size (count tokens before big requests) | Avoid oversized, slow calls |

## Measure

Log per call: model, input tokens, output tokens, cached tokens, success/failure.

The number that matters is **cost per successful task**, not tokens per call — a cheap prompt that fails and retries is expensive.

When you change a prompt, compare before/after on the same test inputs: quality and tokens.

## Security

- Never send secrets or customer personal data.
- Treat retrieved docs and tool output as untrusted input — they can contain instructions (prompt injection).
