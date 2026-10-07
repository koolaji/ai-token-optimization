# Instruction Files, Skills & Tools

Everything in these files is sent with **every** request. A 2,000-token `CLAUDE.md` costs 2,000 tokens on every message of every session.

## Instruction files (`CLAUDE.md`, `AGENTS.md`, system prompts)

Keep:

- build / test / lint commands;
- project conventions that aren't obvious from the code;
- hard rules (e.g. "never apply to prod").

Remove:

- anything the assistant can read from the code itself;
- long introductions and prose;
- the same rule written several ways;
- rules that apply to only one task (move them to a Skill);
- pasted manuals and docs (link them instead).

Put each rule in **one** place only — global file for global rules, project file for project rules.

## Skills

A Skill is loaded only when the task needs it, so it's the right home for repeated, task-specific instructions (e.g. "how we write runbooks", "release checklist").

- One Skill per recurring task — not one giant "DevOps" Skill.
- Structure: purpose → when to use → steps → output format.
- Keep it short; put big reference material in separate files the Skill loads only when needed.
- Few examples: one good example usually beats five similar ones.

## Tools / MCP servers

Every connected MCP server adds its tool definitions to context, even when unused.

- Enable only the servers you use for the current project.
- Prefer tools that support limits and filters (`limit`, `fields`, `since`, search) over tools that return everything.
- If you write an MCP tool: short description, few parameters, small default response size, pagination.
