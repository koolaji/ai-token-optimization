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
