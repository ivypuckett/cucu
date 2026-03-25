#!/bin/bash
# PreToolUse hook: run test suites before any git commit or push.
# Receives tool input as JSON on stdin.

set -euo pipefail

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('command', ''))
except Exception:
    print('')
" <<< "$INPUT" 2>/dev/null || echo "")

# Only intercept git commit / git push
if ! echo "$COMMAND" | grep -qE 'git (commit|push)'; then
  exit 0
fi

REPO="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"

echo "Running tests before commit..." >&2

FAILED=0

echo "--- tests-cli ---" >&2
(cd "$REPO/tests-cli" && bundle exec cucumber --no-color) || FAILED=1

echo "--- tests-js ---" >&2
(cd "$REPO/tests-js" && npm test --silent) || FAILED=1

if [ "$FAILED" -eq 1 ]; then
  echo '{"decision": "block", "reason": "Tests failed — fix failures before committing."}'
  exit 0
fi

echo "All tests passed." >&2
