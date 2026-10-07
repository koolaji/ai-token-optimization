# Ops Recipes

Shrink output **before** it reaches the AI. Rule of thumb: if you wouldn't read it, don't paste it.

## Logs

```bash
# Errors only, deduplicated and counted
grep -iE 'error|fatal|panic|exception' app.log | sort | uniq -c | sort -rn | head -20

# Last part of a log
tail -n 200 app.log

# Time window (systemd)
journalctl -u nginx --since "30 min ago" -p warning --no-pager

# Containers
docker logs --since 15m --tail 200 <container> 2>&1 | grep -iE 'error|warn'
kubectl logs deploy/api --since=15m | grep -iE 'error|warn' | sort | uniq -c | sort -rn | head -20
```

If lines differ only by timestamp/IDs, strip them before `uniq`:

```bash
sed -E 's/^[0-9TZ:.-]+ //; s/[0-9a-f]{8}-[0-9a-f-]{27}/<id>/g' app.log | sort | uniq -c | sort -rn | head
```

## Kubernetes

```bash
kubectl get pods -A | grep -v -E 'Running|Completed'        # only unhealthy pods
kubectl describe pod <pod> | sed -n '/^Events:/,$p'            # only events
kubectl get events --sort-by=.lastTimestamp | tail -20
kubectl logs <pod> --previous --tail=100                       # last crash
kubectl get deploy api -o yaml | yq '.spec.template.spec.containers'  # only the relevant part
```

## Terraform

```bash
terraform plan -no-color | grep -E '^ +# |^Plan:'              # what changes + summary
```

Paste the full block of a single resource only when you ask about that resource.

## CI / build failures

```bash
grep -n -m 20 -iE 'error|failed|fatal' build.log               # first 20 errors with line numbers
tail -n 100 build.log                                          # end of the log, where failures usually are
```

Paste the **first** error — later errors are often consequences of it.

## Stack traces

Keep the exception line and your own code's frames; drop framework/library frames:

```bash
grep -vE 'site-packages|node_modules|/usr/lib/' trace.txt
```

## Git

```bash
git diff --stat                    # overview first
git diff -- path/to/file           # then only the file that matters
git log --oneline -10
```

## JSON / API output

```bash
kubectl get pods -o json | jq -r '.items[] | "\(.metadata.name) \(.status.phase)"'
curl -s api/items | jq '.[0:5] | map({id, status})'           # first 5, only needed fields
```

## Config files

Paste the block in question, not the whole file. Mask secrets:

```bash
sed -E 's/(password|token|secret|key)([^:=]*[:=]\s*).*/\1\2***MASKED***/I' config.yaml
```

## Automate it

CLI output-filtering proxies (for example [RTK](https://github.com/rtk-ai/rtk)) can apply this kind of filtering to every command an AI assistant runs. See [Token-Saving Tools](10-token-saving-tools.md).

Or package a recipe as a skill with a filtering script — see [Creating Skills](12-creating-skills.md).
