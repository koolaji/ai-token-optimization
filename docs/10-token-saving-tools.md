# Token-Saving Tools

Open-source tools that cut tokens automatically, so engineers don't have to remember every rule. Star counts checked on 2026-10-07.

> **Before installing:** hooks, plugins, and MCP servers run code on your machine on every command. Review the source, pin a version, try **one tool at a time**, and measure before/after with a usage tracker (see the last section).

## Built into Claude Code

| Command | Use |
|---|---|
| `/context` | See what is filling the context window (tools, skills, files, history) |
| `/clear` | Start fresh when switching tasks |
| `/compact` | Summarize a long session and keep going |
| `/model` | Switch to a smaller model for simple work |
| `/skill-doctor` | Find unused skills and what they cost in tokens |

## 1. Shrink command output (biggest win for dev & ops)

| Tool | What it does | Install |
|---|---|---|
| [**RTK**](https://github.com/rtk-ai/rtk) ★83k | CLI proxy that filters and compresses output of common commands (`git`, test runners, package managers, `docker`, `kubectl`…) before it reaches the AI. A hook rewrites commands automatically. Claims 60–90% savings on dev commands. | `brew install rtk` then `rtk init -g` (Claude Code / Copilot); `rtk init -g --codex`, `--gemini`, `--agent cursor` for others |
| [**context-mode**](https://github.com/mksglu/context-mode) ★26k | Runs tool output in a sandbox and passes only the relevant part into context; also keeps session memory across compaction. | `/plugin marketplace add mksglu/context-mode` then `/plugin install context-mode@context-mode` |

Check savings with `rtk gain`.

## 2. Shorter AI answers

| Tool | What it does | Install |
|---|---|---|
| [**caveman**](https://github.com/JuliusBrussee/caveman) ★110k | Skill that makes the assistant answer tersely while keeping the technical content. Claims ~65% fewer output tokens; also ships an optional proxy for input. Say `stop caveman` to turn it off. | `claude plugin marketplace add JuliusBrussee/caveman && claude plugin install caveman@caveman` |

Good for experienced engineers; less good for onboarding or explaining to non-experts.

## 3. Read less code

Instead of reading whole files, these tools let the assistant jump straight to the symbol or the affected files.

| Tool | What it does |
|---|---|
| [**Serena**](https://github.com/oraios/serena) ★30k | MCP server with language-server (LSP) navigation: find symbol, references, edit by symbol. Works with Python, Go, Java, C#, and many more. |
| [**code-review-graph**](https://github.com/tirth8205/code-review-graph) ★32k | Builds a code graph so reviews read only the files a change affects. `pip install code-review-graph` |
| [**jcodemunch-mcp**](https://github.com/jgravelle/jcodemunch-mcp) ★2.7k | Symbol-level code retrieval through tree-sitter. |

## 4. Fetch only the docs you need

| Tool | What it does |
|---|---|
| [**Context7**](https://github.com/upstash/context7) ★63k | Pulls current, version-specific library docs on demand, so you don't paste docs and the AI doesn't guess from outdated knowledge. `npx ctx7 setup` |

## 5. Pack code for a chat (use carefully)

| Tool | What it does |
|---|---|
| [**Repomix**](https://github.com/yamadashy/repomix) ★29k | Packs a repo into one file with per-file token counts. Use `--include "src/auth/**"` to pack only what matters and `--compress` (tree-sitter) to keep signatures and drop bodies. Packing the **whole** repo is the anti-pattern this guide warns against. |

## 6. Measure usage

| Tool | What it does |
|---|---|
| [**ccusage**](https://github.com/ccusage/ccusage) ★19k | Daily / session / model token and cost reports from Claude Code logs. `npx ccusage@latest` |
| [**Claude-Code-Usage-Monitor**](https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor) ★8.7k | Live terminal monitor with burn rate and limit predictions. |
| [**claude-usage**](https://github.com/phuryn/claude-usage) ★2.3k | Local web dashboard over Claude Code logs. |

## 7. For apps you build

| Tool | What it does |
|---|---|
| [**LLMLingua**](https://github.com/microsoft/LLMLingua) ★6.7k | Microsoft's prompt compression library — compresses long prompts / RAG context before the LLM call. Measure answer quality after compressing. |

## Recommended starter set

1. **RTK** — everyone running commands through an AI assistant.
2. **ccusage** — to see the effect.
3. **Serena** or **code-review-graph** — teams working in large codebases.
4. **Context7** — teams that often ask about library APIs.

Add the others only if measurement shows a gap.
