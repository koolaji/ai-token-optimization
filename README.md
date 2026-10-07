# AI Token Optimization & Prompt Engineering

> An engineering reference for spending tokens deliberately: prompts, context, Skills, retrieval, tools, agents, models, caching, budgets, and measurement.

**Status:** Technical reference / input for future company regulation
**Scope:** Prompt engineering, context engineering, Skills, retrieval, tool-context design, agent behavior, model routing, caching, token accounting, measurement, and governance.
**Out of scope:** Operational tutorials for Jenkins, Argo CD, Kubernetes, Terraform, or other engineering tools.

---

## Central Philosophy

Token optimization is **not** "make every prompt tiny". It is:

> Give the model exactly the information, instructions, tools, and output budget required to complete the task successfully — without paying repeatedly for information that adds no meaningful value.

```text
MINIMUM NECESSARY INSTRUCTIONS
+ MINIMUM NECESSARY CONTEXT
+ MINIMUM NECESSARY TOOL SURFACE
+ MINIMUM NECESSARY REASONING
+ MINIMUM NECESSARY OUTPUT
= TOKEN-EFFICIENT AI
```

## Golden Rules

```text
Search before Retrieve
Filter before Context
Aggregate before Context
Deduplicate before Context
Retrieve before Loading Everything
Reference before Repeating
Cache before Recomputing
Measure Cache Reuse before Rewriting Stable Prefixes
Skill before Repeated Instructions
Focused Skill before Giant Skill
Small Context before Large Context
Relevant Tool Set before All Tools
Bounded Tool Result before Unbounded Result
Appropriate Model before Largest Model
Appropriate Reasoning before Maximum Reasoning
Structured Output before Verbose Output
Progressive Retrieval before "Just in Case"
Stop when Sufficient
Count before Oversized Requests
Measure before Optimizing
```

## Contents

| # | Document | Sections |
|---|----------|----------|
| 01 | [Foundations](docs/01-foundations.md) | §1–3 Objective, core principle, token surfaces |
| 02 | [Prompts & Outputs](docs/02-prompts-and-outputs.md) | §4–10 Prompt design, output contracts, budgets |
| 03 | [Skills](docs/03-skills.md) | §11–17 Skill size, structure, triggering, progressive disclosure |
| 04 | [Context Engineering](docs/04-context-engineering.md) | §18–35 Relevance, filtering, compression, history, examples, schemas |
| 05 | [Tools](docs/05-tools.md) | §36–41 Tool definitions, deferred loading, tool results |
| 06 | [Agents & Models](docs/06-agents-and-models.md) | §42–52 Iterations, multi-agent, model routing, reasoning, fine-tuning |
| 07 | [Caching](docs/07-caching.md) | §53–59 Prefix architecture, breakpoints, observability |
| 08 | [Token Budgeting](docs/08-token-budgeting.md) | §60–66 Preflight, budgets, soft/hard limits, overflow |
| 09 | [Retrieval / RAG](docs/09-retrieval.md) | §67–75 Top-K, thresholds, reranking, chunking |
| 10 | [Instructions & Templates](docs/10-instructions-and-templates.md) | §76–80 Instruction hierarchy, templates |
| 11 | [Compression & Token-Aware Behavior](docs/11-compression-and-token-aware-behavior.md) | §81–98 Density, compression, retries, validation, parallelism |
| 12 | [Measurement & Governance](docs/12-measurement-and-governance.md) | §99–114 Versioning, regression tests, metrics |
| 13 | [Checklists & Anti-Patterns](docs/13-checklists.md) | §115–120 |
| 14 | [Framework & Philosophy](docs/14-framework-and-philosophy.md) | §121–123 |
| — | [Research Notes & Sources](docs/research-notes.md) | Research-backed additions, official references |
| — | [Roadmap](ROADMAP.md) | Next phase: turning this into a regulation |

## Optimization Framework

1. Prompt Optimization
2. Skill Optimization
3. Context Optimization
4. Retrieval Optimization
5. Tool Definition Optimization
6. Tool Result Optimization
7. Agent Optimization
8. Model / Reasoning Optimization
9. Output Optimization
10. Cache Optimization
11. Token Budgeting
12. Measurement & Governance

## Contributing

Contributions are welcome — see [CONTRIBUTING.md](CONTRIBUTING.md). In keeping with the subject matter: every addition should earn its tokens.

## License

[CC BY 4.0](LICENSE) — share and adapt with attribution.
