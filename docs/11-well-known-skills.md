# Well-Known Skills

Skills are reusable instruction packages (a folder with a `SKILL.md`). The format is an [open standard](https://agentskills.io) supported by Claude Code, Codex, Gemini CLI, Cursor, GitHub Copilot / VS Code, JetBrains Junie, OpenCode, Goose, Roo Code, Kiro, and many more — write once, use in any of them.

Star counts checked on 2026-10-07.

> **Token cost:** every installed skill puts its name + description into context in **every** session, and its full body when used. Big skill frameworks can add many skills at once. Install only what your team actually uses, and check with `/skill-doctor`.
>
> **Security:** a skill can run scripts and pre-approve tools (`allowed-tools`). Read it before installing — especially from unknown authors.

## Official

| Repo | Highlights |
|---|---|
| [anthropics/skills](https://github.com/anthropics/skills) ★180k | `skill-creator` (build & test your own skills), `mcp-builder` (build MCP servers), `webapp-testing`, `claude-api`, `pdf` / `docx` / `xlsx` / `pptx` document skills |
| [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) ★37k | Anthropic-managed directory of Claude Code plugins (many bundle skills) |
| [dotnet/skills](https://github.com/dotnet/skills) ★5.6k | Official .NET / C# skills from the .NET team |
| [hashicorp/agent-skills](https://github.com/hashicorp/agent-skills) | Official HashiCorp skills (Terraform and other HashiCorp products) |

## General engineering

| Repo | What it is |
|---|---|
| [obra/superpowers](https://github.com/obra/superpowers) ★296k | Full development methodology as skills: brainstorm → plan → TDD → systematic debugging → review |
| [mattpocock/skills](https://github.com/mattpocock/skills) ★279k | Everyday engineering skills from Matt Pocock's own setup |
| [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) ★102k | Production engineering skills, incl. `ci-cd-and-automation`, `observability-and-instrumentation`, `security-and-hardening`, `debugging-and-error-recovery`, `code-review-and-quality`, `context-engineering`, `git-workflow-and-versioning` |
| [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) ★217k | A single `CLAUDE.md` with behavior rules based on Andrej Karpathy's observations on LLM coding mistakes |
| [garrytan/gstack](https://github.com/garrytan/gstack) ★136k | Garry Tan's opinionated setup: 23 role-based tools (eng manager, QA, release manager…). Large — adopt selectively. |

## Token saving

| Repo | What it is |
|---|---|
| [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) ★110k | Terse-answer skill (see [Token-Saving Tools](10-token-saving-tools.md)) |

## DevOps & cloud

| Repo | What it is |
|---|---|
| [antonbabenko/terraform-skill](https://github.com/antonbabenko/terraform-skill) ★2.4k | Terraform & OpenTofu: testing, modules, CI/CD, production patterns |
| [hashicorp/agent-skills](https://github.com/hashicorp/agent-skills) | Official HashiCorp product skills |
| [itsmostafa/aws-agent-skills](https://github.com/itsmostafa/aws-agent-skills) ★1.2k | AWS skills |
| [Agents365-ai/drawio-skill](https://github.com/Agents365-ai/drawio-skill) ★10k | Generate draw.io diagrams from Terraform, K8s manifests, code |

## By language

| Language | Repo |
|---|---|
| Go | [samber/cc-skills-golang](https://github.com/samber/cc-skills-golang) ★3.4k |
| .NET | [dotnet/skills](https://github.com/dotnet/skills) ★5.6k (official), [Aaronontheweb/dotnet-skills](https://github.com/Aaronontheweb/dotnet-skills) ★1.2k |
| Java / Spring Boot | [sivaprasadreddy/sivalabs-agent-skills](https://github.com/sivaprasadreddy/sivalabs-agent-skills), [jdubois/dr-jskill](https://github.com/jdubois/dr-jskill) |

## Directories (to find more)

- [ComposioHQ/awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills) ★77k
- [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) ★55k
- [travisvn/awesome-claude-skills](https://github.com/travisvn/awesome-claude-skills) ★15k

## Installing

```bash
# Claude Code plugin marketplace (repo ships a plugin)
/plugin marketplace add <owner>/<repo>
/plugin install <plugin>@<marketplace>

# Cross-agent installer used by many skill repos
npx skills add <owner>/<repo>

# Manual: copy the skill folder
cp -r some-skill ~/.claude/skills/        # personal, all projects
cp -r some-skill .claude/skills/          # project, shared through git
```

Check each repo's README for its exact command.

## Recommendation for the team

1. **Everyone:** `skill-creator` (to build team skills) + RTK.
2. **Per team, pick one** methodology at most (superpowers *or* addyosmani *or* gstack) — they overlap.
3. **Language/infra skills** only in the projects that use that stack (install at project level, not globally).
4. **Our own skills** for our own procedures — see [Creating Skills](12-creating-skills.md).
