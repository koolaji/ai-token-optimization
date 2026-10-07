# 03 · Skills

## 11. Skills

Repeated stable instructions should be centralized in Skills or equivalent reusable instruction components.

Benefits:

- lower instruction duplication;
- more consistent behavior;
- easier review;
- easier token benchmarking;
- easier caching;
- easier version control.

Skills should not become dumping grounds for every related document.

## 12. Skill Size

Skills themselves consume context.

```text
More Skill Content ≠ Better Skill
```

Avoid:

- long introductions;
- unnecessary prose;
- duplicated rules;
- excessive examples;
- embedded manuals;
- unrelated edge cases;
- information already available through retrieval.

## 13. Skill Structure

A token-efficient Skill can contain:

```text
Purpose
Trigger
Required Inputs
Procedure
Constraints
Output Contract
References
```

Large supporting material should be retrieved only when needed.

## 14. Skill Decomposition

Avoid giant universal Skills.

Prefer focused Skills aligned with recurring task classes.

Only relevant Skills should enter context.

## 15. Skill Triggering

Use:

```text
User Intent
→ Skill Selection
→ Relevant Skill
```

Avoid:

```text
Every Skill
→ Every Request
```

Skill routing itself should be lightweight.

## 16. Skill References / Progressive Loading

Prefer:

```text
Skill
→ Need specific standard?
→ Load specific reference
```

over embedding every possible standard into the Skill.

This is progressive disclosure applied to instructions.

## 17. Progressive Disclosure

Start with minimum instructions and minimum context.

```text
Level 1 → Task
Level 2 → Metadata
Level 3 → Relevant context
Level 4 → Supporting context
Level 5 → Extended investigation
```

Do not start at the maximum context level.

---

Previous: [02 · Prompts & Outputs](02-prompts-and-outputs.md) · Next: [04 · Context Engineering](04-context-engineering.md)
