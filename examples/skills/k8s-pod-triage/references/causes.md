# Common causes

| Signal | Likely cause | Fix |
|---|---|---|
| `OOMKilled`, exit 137 | Memory limit too low or leak | Raise `resources.limits.memory` or fix the leak |
| `CrashLoopBackOff`, exit 1 | App error at startup | Read the error lines; usually config/env/dependency |
| `ImagePullBackOff` / `ErrImagePull` | Wrong image/tag or missing pull secret | Fix image reference or `imagePullSecrets` |
| `CreateContainerConfigError` | Missing Secret/ConfigMap or key | Create it or fix the reference |
| `Pending` + `FailedScheduling` `Insufficient cpu/memory` | No node has room | Lower requests or add capacity |
| `Pending` + taint / node affinity message | No matching node | Fix tolerations / affinity / nodeSelector |
| `Pending` + `unbound PersistentVolumeClaim` | Storage not provisioned | Check StorageClass and PVC |
| `Readiness probe failed` | App not ready on probe path/port | Fix probe path/port/timing |
| `Liveness probe failed` + restarts | App hangs or probe too strict | Fix app or relax `initialDelaySeconds` / `timeoutSeconds` |
| `connection refused` / `timeout` in logs | Dependency down or wrong address | Check Service name, port, NetworkPolicy |
