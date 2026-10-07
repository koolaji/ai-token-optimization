# 02 · Prompts & Outputs

## 4. Prompt Engineering

Prompts should be:

- concise;
- explicit;
- task-focused;
- non-repetitive;
- structured;
- clear about scope;
- clear about required output;
- clear about stopping conditions when relevant.

Prefer:

```text
Review this change for security issues.
Return:
- severity
- location
- issue
- recommendation
```

Avoid verbose wording that does not add a constraint or useful signal.

## 5. Remove Prompt Redundancy

Bad:

```text
Be concise.
Keep the answer short.
Don't write too much.
Only provide necessary information.
Avoid unnecessary explanation.
```

Better:

```text
Respond concisely.
```

Audit prompts for semantically duplicated instructions, not just exact duplicated strings.

## 6. Explicit Task Definition

Ambiguous prompts can increase consumption because the model may explore unnecessary interpretations, retrieve more information, or generate longer responses.

Define:

```text
Task
Scope
Constraints
Required Evidence
Output
```

Example:

```text
Task: Review the configuration change.
Scope: Security risks only.
Evidence: Cite the changed element.
Output: Findings with severity and recommendation.
```

## 7. Output Contracts

Define exactly what is required.

Instead of:

```text
Analyze this.
```

prefer:

```text
Return:
1. Root cause
2. Evidence
3. Recommended fix
```

Output contracts reduce speculative generation and improve downstream parsing.

## 8. Output Token Budgets

Different workloads should have different expected output sizes.

```text
Classification      → Very Small
Extraction          → Very Small
Simple Q&A          → Small
Code Review         → Medium
Troubleshooting     → Medium
Architecture        → Large
Research            → Large
```

Do not use one global output allowance for all workflows.

## 9. Avoid Unnecessary Explanations

For machine-consumed workflows, do not request background, tutorials, alternatives, summaries, or conclusions unless they are consumed downstream.

Compact structured output can be preferable:

```json
{
  "status": "failed",
  "cause": "configuration_mismatch",
  "confidence": 0.94
}
```

## 10. Human Output vs Machine Output

### Machine-facing

Prefer:

```text
Compact
Structured
Deterministic
Minimal
```

### Human-facing

May require:

```text
Explanation
Evidence
Recommendation
Context
```

Do not use verbose human prose as the default communication format between automated agents.

---

Previous: [01 · Foundations](01-foundations.md) · Next: [03 · Skills](03-skills.md)
