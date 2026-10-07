# Coding with AI: Python, Go, Java, .NET

Same rules everywhere: point at the code, shrink build/test output, keep generated and dependency files out of context.

## Point, don't paste

```text
Bad:  [pastes 3 files] "something is wrong with auth"
Good: "TestValidateToken fails in internal/auth/token_test.go.
       Fix Validate() in internal/auth/token.go. Return the diff only."
```

- Name the file, function, and failing test.
- Ask for a diff, not the whole file.
- Say "follow the existing style" instead of explaining your style.
- Put build/test commands in `CLAUDE.md` / `AGENTS.md` (one line each) so the assistant doesn't explore to find them.

## Keep out of context

| Language | Exclude |
|---|---|
| Python | `.venv/`, `__pycache__/`, `*.egg-info/`, `dist/`, `.mypy_cache/`, `poetry.lock`, `uv.lock` |
| Go | `vendor/`, `*.pb.go` and other generated files, `go.sum` |
| Java | `target/`, `build/`, `.gradle/`, generated sources |
| .NET | `bin/`, `obj/`, `packages/`, `*.Designer.cs`, migration snapshots |

For generated code, point at the source (`.proto`, OpenAPI spec), not the output.

Claude Code example (`.claude/settings.json`):

```json
{
  "permissions": {
    "deny": ["Read(./vendor/**)", "Read(./target/**)", "Read(./bin/**)", "Read(./obj/**)"]
  }
}
```

## Quiet build & test commands

Run (or let the assistant run) only the failing scope, with minimal output.

### Python

```bash
pytest -q -x --tb=short                      # stop at first failure, short traceback
pytest -q --lf                               # rerun only last failures
pytest -q tests/test_auth.py::test_token     # one test
ruff check --output-format concise .
```

### Go

```bash
go test ./... 2>&1 | grep -E '^(--- FAIL|FAIL|panic|ok )' # only results
go test -failfast -run TestValidateToken ./internal/auth/
go vet ./... 2>&1 | head -20
```

### Java

```bash
mvn -B -q test                                # Maven: errors only
mvn -B -q -Dtest=TokenServiceTest test        # one test class
./gradlew test -q --console=plain             # Gradle
./gradlew test --tests 'com.acme.auth.TokenServiceTest'
```

### .NET

```bash
dotnet build -v q -clp:ErrorsOnly --nologo
dotnet test -v q --nologo
dotnet test --filter "FullyQualifiedName~TokenServiceTests"
```

## Stack traces

Keep the exception and your own frames; drop runtime/framework frames.

```bash
# Python: the last lines are the most important
tail -n 25 trace.txt

# Go panic: keep only the panicking goroutine (it is printed first)
awk '/^goroutine /{n++} n<2' panic.txt

# Java
grep -vE '^\s+at (java\.|javax\.|jdk\.|sun\.|org\.springframework\.|org\.junit\.)|^\s+\.\.\. [0-9]+ more' trace.txt

# .NET
grep -vE '^\s+at (System\.|Microsoft\.)' trace.txt
```

## Calling LLM APIs from your code

Official SDKs exist for all four languages from the major providers. Whatever the language:

- every response includes a token **usage** object — log it (input, output, cached);
- set `max_tokens` per call type;
- keep the stable system prompt first and the variable data last (prompt caching);
- see [Building AI Automations](04-automation.md) for the full list.
