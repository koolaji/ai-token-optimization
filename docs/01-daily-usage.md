# Daily Usage

## Prompt: task, scope, output

Bad:

```text
Can you take a look at this and tell me what you think? [500 lines of YAML]
```

Good:

```text
Review this Deployment for security issues only.
Return: line, issue, fix. No explanation.
[the 40 relevant lines]
```

- Say it once. "Be concise. Keep it short. Don't write too much." → `Respond concisely.`
- Use a positive rule instead of a list of "don'ts": `Return only the requested fields.`
- If the answer is for a script, ask for JSON with only the fields you read.

## Context: give the minimum that answers the question

| Instead of | Give |
|---|---|
| Full log file | Errors from the time window, counted and deduplicated |
| Whole repository | The file and function involved |
| Full `kubectl describe` | The `Events:` section |
| Full `terraform plan` | Changed resources + `Plan:` summary |
| 500 identical errors | `Error X occurred 500 times` + 2 samples |
| The whole doc page | The section that matters, or the link |

See [Ops Recipes](02-ops-recipes.md) for ready-made commands.

## Sessions

- **New task → new session** (Claude Code: `/clear`; chat tools: new chat). Old context is re-sent and paid for on every message.
- **Long task → compact** (Claude Code: `/compact`) once the history is mostly dead ends.
- **Don't re-paste** the assistant's previous answer back to it — it already has it.
- When a requirement changes, state the new requirement clearly; don't leave both versions competing.

## Output

- Ask for the fix, not a tutorial.
- Ask for a diff or the changed lines, not the whole rewritten file.
- Ask for "answer + one-line reason", not step-by-step reasoning.
- Skip summaries you won't read.

## Model and effort

| Task | Use |
|---|---|
| Rename, format, simple regex, quick question | Small / fast model, low effort |
| Normal coding, reviewing a change | Standard model |
| Hard debugging, multi-system root cause, design | Strongest model, higher effort |

Start small; switch up only if the result is not good enough.

## Agents

- Give a clear stop condition: "Stop when you find the root cause; don't fix it."
- Interrupt when it loops (same search/read repeated without progress).
- Don't ask for "review → critic → verifier" chains on simple tasks. Ask for extra review only for risky changes (prod, security, data).
- Parallel agents are faster but each one pays for its own context — use them only for genuinely independent work.
