# LangChain

Practical token savings with LangChain / LangGraph. Verified against `langchain` 1.4, `langchain-core` 1.6, `langgraph` 1.2 — check the docs if you're on another version.

## 1. Measure first

Every chat-model response carries `usage_metadata`. To total a whole run (chains, agents, multiple calls):

```python
from langchain_core.callbacks import get_usage_metadata_callback

with get_usage_metadata_callback() as cb:
    result = agent.invoke({"messages": [("user", question)]})
print(cb.usage_metadata)  # per model: input, output, cache read/write tokens
```

LangSmith tracing shows the same per step — use it to find which step is expensive.

## 2. Limit output

```python
from langchain.chat_models import init_chat_model

model = init_chat_model("anthropic:claude-haiku-4-5", max_tokens=300)
```

Use structured output so the model returns only the fields you need:

```python
from pydantic import BaseModel

class Triage(BaseModel):
    severity: str
    component: str
    cause: str

triage = model.with_structured_output(Triage).invoke(alert_text)
```

## 3. Retrieval: small Top-K, threshold, diversity

```python
# Drop weak matches
retriever = vectorstore.as_retriever(
    search_type="similarity_score_threshold",
    search_kwargs={"k": 4, "score_threshold": 0.5},
)

# Or MMR: fetch 20 candidates, return 4 diverse ones (less near-duplicate text)
retriever = vectorstore.as_retriever(
    search_type="mmr",
    search_kwargs={"k": 4, "fetch_k": 20},
)
```

Tune `score_threshold` on your data — score scales differ between vector stores.

## 4. Chunking

```python
from langchain_text_splitters import RecursiveCharacterTextSplitter, MarkdownHeaderTextSplitter, Language

# Size chunks in tokens, not characters, with little overlap
splitter = RecursiveCharacterTextSplitter.from_tiktoken_encoder(chunk_size=400, chunk_overlap=40)

# Split code on functions/classes
go_splitter = RecursiveCharacterTextSplitter.from_language(Language.GO, chunk_size=800, chunk_overlap=0)
# also Language.PYTHON, Language.JAVA, Language.CSHARP

# Split docs/runbooks on headings
md_splitter = MarkdownHeaderTextSplitter(headers_to_split_on=[("#", "h1"), ("##", "h2")])
```

## 5. Don't re-embed unchanged docs

The indexing API skips content that hasn't changed and cleans up deleted docs:

```python
from langchain_core.indexing import index

index(
    docs, record_manager, vectorstore,
    cleanup="incremental", source_id_key="source", key_encoder="sha256",
)
```

Use a persistent record manager (e.g. SQL-backed) in production; `InMemoryRecordManager` is for tests.

Cache embeddings for repeated content: `CacheBackedEmbeddings` (in `langchain_classic.embeddings`).

## 6. Conversation history

Don't send the entire history every turn. Trim it:

```python
from langchain_core.messages import trim_messages

messages = trim_messages(
    history, max_tokens=2000, token_counter="approximate",
    strategy="last", start_on="human", include_system=True,
)
```

`token_counter="approximate"` runs locally. Passing the model instead can call the provider's token-counting API on every trim.

## 7. Agents: middleware for limits and context

```python
from langchain.agents import create_agent
from langchain.agents.middleware import (
    ModelCallLimitMiddleware, ToolCallLimitMiddleware,
    SummarizationMiddleware, LLMToolSelectorMiddleware,
)

agent = create_agent(
    model="anthropic:claude-sonnet-5-5",
    tools=tools,
    system_prompt="You are an on-call assistant. Answer with cause and fix only.",
    middleware=[
        ModelCallLimitMiddleware(run_limit=10),            # stop runaway loops
        ToolCallLimitMiddleware(run_limit=15),
        SummarizationMiddleware(                           # compress long history
            model="anthropic:claude-haiku-4-5",
            trigger=("tokens", 8000), keep=("messages", 10),
        ),
        LLMToolSelectorMiddleware(max_tools=5),            # send only relevant tools when you have many
    ],
)
```

Also available: `ContextEditingMiddleware` (clears old tool results), `ModelFallbackMiddleware`, and for Anthropic models `AnthropicPromptCachingMiddleware` (`langchain_anthropic.middleware`).

## 8. Tools

The tool name, docstring, and arguments are sent on **every** model call.

```python
from langchain_core.tools import tool

@tool
def get_pod_errors(pod: str, since: str = "15m", limit: int = 50) -> str:
    """Return deduplicated error lines from a pod's logs."""
    ...
```

- Short docstring, few arguments.
- Filter and limit **inside** the tool; return a compact string, not raw JSON dumps.

## 9. Caching

- **Provider prompt caching** (biggest win): keep the system prompt and tools identical across calls, variable data last. For Anthropic use `AnthropicPromptCachingMiddleware`.
- **Exact-match LLM cache** (dev, tests, repeated identical calls):
  ```python
  from langchain_core.globals import set_llm_cache
  from langchain_core.caches import InMemoryCache
  set_llm_cache(InMemoryCache())
  ```

## Gotchas

| Pattern | Hidden cost |
|---|---|
| `model.batch([...])` | Runs calls in parallel — it is **not** the provider's discounted Batch API. Use the provider's batch API for bulk, non-urgent jobs. |
| Multi-query retrievers | One extra LLM call per query, plus several searches. |
| Parent-document retrieval | Returns large parent docs — big prompts. |
| "Stuff" everything into one prompt | Works on small docs, explodes on large ones. |
| LLM-based compressors / rerankers | Extra LLM call per query — make sure it saves more than it costs. |
| Agents with no limits | Loops and retries multiply cost silently. |

See also: [RAG](07-rag.md), [Embedding Models](08-embeddings.md).
