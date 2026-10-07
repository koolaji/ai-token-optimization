# 01 · Foundations

## 1. Primary Objective

The objective is not simply to minimize tokens.

```text
Minimum Necessary Tokens
+ Required Context
+ Required Answer Quality
+ Acceptable Latency
+ Acceptable Cost
```

Optimization must preserve task success and reliability. A smaller prompt that causes retries, model escalation, or incorrect results can be less efficient overall.

## 2. Core Principle

Every token entering or leaving an LLM should have a purpose.

Before adding context:

```text
Does the model need this information
to complete the current reasoning step?
```

Before requesting output:

```text
Will this output actually be consumed?
```

Preferred flow:

```text
Understand Task
→ Select Minimum Instructions
→ Search
→ Filter
→ Retrieve Minimum Context
→ Reason
→ Produce Minimum Required Output
```

Avoid:

```text
Collect Everything
→ Send Everything
→ Ask LLM to Find What Matters
```

## 3. Token Consumption Surfaces

Token optimization must consider all token-producing surfaces:

- system/developer instructions;
- Skills;
- user prompts;
- few-shot examples;
- tool definitions;
- tool schemas;
- conversation history;
- retrieved context;
- tool results;
- multimodal inputs where applicable;
- reasoning/thinking tokens where exposed by the provider;
- model output;
- agent-to-agent messages;
- retries and repeated calls.

Optimizing only the user's prompt addresses only one part of the total cost.

---

Next: [02 · Prompts & Outputs](02-prompts-and-outputs.md)
