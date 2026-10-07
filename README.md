# AI Token Optimization for Dev & Ops

A practical guide for developers and operations engineers who use AI assistants (Claude Code, Copilot, ChatGPT, etc.) or build small AI automations — get the same results with fewer tokens.

Fewer tokens means lower cost, faster answers, and usually **better** answers: models get worse when buried in noise.

## The 10 Rules

1. **Filter before you paste.** `grep`, `tail`, `jq` first — never dump raw logs, full files, or full command output.
2. **Say exactly what you want.** Task, scope, and output format in one or two lines.
3. **Ask only for output you will use.** "Return only the fix" beats "explain this".
4. **One task, one session.** Clear or restart the session when you switch topics.
5. **Point, don't paste.** Give a file path, line number, or error line — let the assistant read only what it needs.
6. **Keep instruction files short.** `CLAUDE.md` / `AGENTS.md` / system prompts are paid on every request.
7. **Enable only the tools you need.** Every connected MCP server / plugin adds its definitions to context.
8. **Use the smallest model that works.** Escalate only when the answer is not good enough.
9. **Stop loops early.** If the assistant repeats search → read → search without progress, stop and redirect.
10. **Never paste secrets.** Tokens, passwords, kubeconfigs, `.env` files — mask them first.

## Guides

| Guide | For |
|---|---|
| [Daily Usage](docs/01-daily-usage.md) | Prompting, sessions, output, model choice |
| [Ops Recipes](docs/02-ops-recipes.md) | Copy-paste commands to shrink logs, k8s, Terraform, CI output |
| [Instruction Files, Skills & Tools](docs/03-instructions-skills-tools.md) | `CLAUDE.md`, Skills, MCP servers |
| [Building AI Automations](docs/04-automation.md) | Scripts, bots, and CI jobs that call LLM APIs |
| [Checklist](docs/05-checklist.md) | One-page review before you hit Enter |
| [Coding: Python, Go, Java, .NET](docs/06-coding-by-language.md) | Quiet build/test commands, stack traces, what to keep out of context |
| [RAG](docs/07-rag.md) | Top-K, thresholds, chunking, reranking, dedup |
| [Embedding Models](docs/08-embeddings.md) | Re-indexing, input limits, caching, choosing a model |
| [LangChain](docs/09-langchain.md) | Usage tracking, retrievers, splitters, history trimming, agent limits |

## License

[CC BY 4.0](LICENSE)
