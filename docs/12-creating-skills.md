# Creating Skills

A skill turns a procedure you keep re-explaining into a folder the assistant loads **only when needed**. Done right, it saves tokens twice: no repeated instructions in prompts, and no bloated `CLAUDE.md`.

Based on the [Agent Skills specification](https://agentskills.io/specification) and the [Claude Code skills docs](https://code.claude.com/docs/en/skills).

## Skill or `CLAUDE.md`?

| Put it in `CLAUDE.md` | Put it in a skill |
|---|---|
| Needed in almost every session | Needed only for one kind of task |
| A few lines (build/test commands, hard rules) | A procedure, checklist, or reference material |
| | Has a script that does the work |

## How it loads (why skills are cheap)

| Stage | What enters context | Budget |
|---|---|---|
| Startup | `name` + `description` of every skill | ~100 tokens per skill |
| Skill triggered | Full `SKILL.md` body | under ~5,000 tokens / 500 lines |
| As needed | Files in `references/`, output of `scripts/` | Only what's read or printed |

A script's **code** never enters context — only its **output**. Move deterministic work (filtering, parsing, counting) into scripts.

## Folder layout

```text
k8s-pod-triage/
├── SKILL.md          # required: frontmatter + instructions
├── scripts/          # optional: code the agent runs
├── references/       # optional: docs loaded on demand
└── assets/           # optional: templates, schemas
```

Where to put it (Claude Code):

| Scope | Path |
|---|---|
| Personal (all your projects) | `~/.claude/skills/<name>/SKILL.md` |
| Project (shared via git) | `.claude/skills/<name>/SKILL.md` |
| Plugin (shared via marketplace) | `<plugin>/skills/<name>/SKILL.md` |

## Frontmatter

Required by the standard:

| Field | Rules |
|---|---|
| `name` | 1–64 chars, lowercase `a-z`, `0-9`, `-`; no leading/trailing or double hyphens; **must match the folder name** |
| `description` | 1–1,024 chars; what it does **and when to use it**, with the words users actually say |

Useful optional fields:

| Field | Use |
|---|---|
| `allowed-tools` | Pre-approve specific commands, e.g. `Bash(kubectl get *)` |
| `license`, `compatibility`, `metadata` | Standard fields (license, requirements, version/owner) |

Claude Code extras (ignored by other agents):

| Field | Use | Token effect |
|---|---|---|
| `disable-model-invocation: true` | Only runs when a user types `/name`. Use for side effects (deploy, release). | Description is **not** loaded into context at all |
| `context: fork` | Runs in an isolated subagent; only the result comes back | Main session stays clean |
| `paths` | Glob patterns, e.g. `["**/*.tf"]` — only activates for matching files | Fewer false triggers |
| `model`, `effort` | Use a cheaper model / lower effort for simple skills | Cheaper runs |

## Writing the description

It decides **when** the skill loads — the most important line in the skill.

```yaml
# Bad — vague, never triggers or triggers on everything
description: Helps with Kubernetes.

# Good — what + when + trigger words
description: Diagnose failing Kubernetes pods (CrashLoopBackOff, OOMKilled,
  ImagePullBackOff, Pending). Use when a pod is not Running, keeps restarting,
  or the user pastes a pod error.
```

## Writing the body

- Imperative steps, not essays. State **what** to do.
- One output contract at the end.
- No introductions, no repeated rules, no copied manuals — link a `references/` file instead.
- Keep reference files one level deep from `SKILL.md`.
- One skill per task. Split a giant "devops" skill into `k8s-pod-triage`, `terraform-plan-review`, `release-notes`, …

## Complete example

A ready-to-copy version lives in [`examples/skills/k8s-pod-triage`](../examples/skills/k8s-pod-triage).

`SKILL.md`:

```markdown
---
name: k8s-pod-triage
description: Diagnose failing Kubernetes pods (CrashLoopBackOff, OOMKilled, ImagePullBackOff, Pending). Use when a pod is not Running, keeps restarting, or the user pastes a pod error.
allowed-tools: Bash(${CLAUDE_SKILL_DIR}/scripts/triage.sh *)
metadata:
  owner: devops
  version: "1.0"
---

# Pod triage

1. Run `${CLAUDE_SKILL_DIR}/scripts/triage.sh <namespace> <pod>`.
   It prints status, last termination reason, recent events, and deduplicated error lines.
2. If the cause isn't obvious, read [references/causes.md](references/causes.md).
3. Read-only: never run `kubectl delete`, `edit`, `apply`, or `rollout`.

Output:
- cause: one line
- evidence: up to 3 lines quoted from the script output
- fix: the command or manifest change
```

Why it's token-efficient:

- The script filters `kubectl` output — the model sees ~30 lines instead of thousands.
- `causes.md` is read only when needed.
- Fixed output format — no essays.

## Claude Code: inject filtered data up front

`` !`command` `` runs before the model sees the skill and inserts the output. Always filter it:

```markdown
## Failing pods
!`kubectl get pods -A --no-headers | grep -vE 'Running|Completed' | head -20`
```

## Test it

1. **Validate format:** `skills-ref validate ./k8s-pod-triage` — install [skills-ref](https://github.com/agentskills/agentskills/tree/main/skills-ref) from the repo (`git clone https://github.com/agentskills/agentskills && pip install ./agentskills/skills-ref`).
2. **Trigger test:** ask 5 prompts that **should** trigger it and 5 that **shouldn't**. Fix the description until both pass.
3. **Compare:** run the same task with and without the skill in fresh sessions — compare result quality and tokens (`/context`, ccusage).
4. **Automate:** the `skill-creator` skill (in [anthropics/skills](https://github.com/anthropics/skills)) can draft skills and run evals for you.
5. **Clean up:** `/skill-doctor` shows unused skills and their token cost.

## Share with the team

- Commit project skills in `.claude/skills/` — everyone gets them with `git pull`.
- For many repos: publish a plugin / internal marketplace, or a shared skills repo.
- Treat skills as code: review, owner, version in `metadata`, changelog.

## Checklist

- [ ] `name` matches folder, lowercase-hyphen
- [ ] `description` says what + when, with trigger words
- [ ] Body under 500 lines; big material in `references/`
- [ ] Deterministic work in `scripts/`, output filtered
- [ ] Fixed output format
- [ ] Side-effect skills use `disable-model-invocation: true`
- [ ] `allowed-tools` as narrow as possible
- [ ] Tested: triggers when it should, not when it shouldn't
