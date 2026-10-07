# Checklist

## Before you send

- [ ] Did I filter logs/output (`grep`, `tail`, `jq`)?
- [ ] Did I remove duplicates and repeated errors?
- [ ] Is this the right session, or should I start a new one?
- [ ] Did I state task, scope, and output format?
- [ ] Am I asking only for output I will use?
- [ ] Is this the smallest model that can do it?
- [ ] No secrets in the paste?

## Setup (once per project)

- [ ] `CLAUDE.md` / `AGENTS.md` short, no duplicated rules
- [ ] Task-specific instructions moved into Skills
- [ ] Only needed MCP servers enabled
- [ ] RTK (or similar) installed; usage measured with ccusage
- [ ] Only skills the team uses are installed (`/skill-doctor`)

## Automations

- [ ] JSON output with only needed fields
- [ ] `max_tokens` set per job
- [ ] Stable prompt prefix first, variable data last (caching)
- [ ] Iteration, tool-call, and retry limits
- [ ] Batch API for non-urgent bulk work
- [ ] Token usage and success logged

## Coding

- [ ] Pointed at file/function/test instead of pasting files
- [ ] Ran only the failing test, with quiet output
- [ ] `vendor/`, `target/`, `bin/`, `obj/`, `.venv/`, generated code excluded

## RAG / embeddings / LangChain

- [ ] Small Top-K + relevance threshold
- [ ] Chunks split on natural boundaries, low overlap, under the embedding model's input limit
- [ ] Unchanged docs not re-embedded
- [ ] History trimmed or summarized
- [ ] Agent call/tool-call limits set
- [ ] Token usage measured per run

## Avoid

```text
Whole repo / whole log / whole doc → AI
Every MCP server always on
Giant instruction file
Largest model for everything
"Explain everything" when you need one line
One endless session for all tasks
Unlimited agent loops and retries
Top-K 20 "just in case"
Re-embedding everything on every deploy
```
