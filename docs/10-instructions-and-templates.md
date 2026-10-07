# 10 · Instructions & Templates

## 76. Instruction Hierarchy

Avoid repeating the same rule across:

```text
System Instructions
Developer Instructions
Skill
Prompt Template
User Prompt
Tool Description
```

Place each stable rule at the narrowest correct layer.

## 77. Global vs Local Instructions

Global instructions should be genuinely global.

Task-specific behavior belongs in task/Skill instructions.

Request-specific details belong in the current request.

This prevents unrelated instructions from taxing every call.

## 78. Positive Compression of Negative Rules

Bad:

```text
Don't provide explanation.
Don't provide examples.
Don't provide background.
Don't provide summary.
```

Better:

```text
Return only the requested fields.
```

Use concise positive constraints when semantically equivalent.

## 79. Prompt Templates

Standardize high-volume prompts.

Benefits:

- predictable token use;
- easier caching;
- easier benchmarking;
- easier evaluation;
- easier regression testing;
- less prompt duplication.

## 80. Static vs Dynamic Template Sections

Separate:

```text
Static Instructions
+
Dynamic Variables
+
Dynamic Retrieved Context
```

This improves maintainability and can improve prefix-cache reuse.

---

Previous: [09 · Retrieval / RAG](09-retrieval.md) · Next: [11 · Compression & Token-Aware Behavior](11-compression-and-token-aware-behavior.md)
