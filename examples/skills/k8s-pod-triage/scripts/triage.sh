#!/usr/bin/env bash
# Compact, read-only pod diagnosis for AI assistants.
set -euo pipefail
ns="${1:?usage: triage.sh <namespace> <pod>}"
pod="${2:?usage: triage.sh <namespace> <pod>}"

echo "## status"
kubectl get pod "$pod" -n "$ns" -o jsonpath='{.status.phase}{"\n"}{range .status.containerStatuses[*]}{.name}: ready={.ready} restarts={.restartCount} waiting={.state.waiting.reason} lastTerminated={.lastState.terminated.reason} exit={.lastState.terminated.exitCode}{"\n"}{end}'

echo "## events (last 10)"
kubectl get events -n "$ns" --field-selector "involvedObject.name=$pod" --sort-by=.lastTimestamp \
  -o custom-columns=TYPE:.type,REASON:.reason,MESSAGE:.message --no-headers | tail -n 10

echo "## errors (previous container if it restarted; counted, top 15)"
{ kubectl logs "$pod" -n "$ns" --all-containers --previous --tail=500 2>/dev/null \
  || kubectl logs "$pod" -n "$ns" --all-containers --tail=500; } \
  | grep -iE 'error|fatal|panic|exception|refused|timeout' \
  | sed -E 's/^[0-9TZ:.+-]+ //' | sort | uniq -c | sort -rn | head -n 15 || true
