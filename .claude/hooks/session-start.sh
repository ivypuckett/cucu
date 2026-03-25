#!/bin/bash
set -uo pipefail

# Only run in remote (web) sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

echo '{"async": true, "asyncTimeout": 300000}'

REPO="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"

# Install go-task if missing
if ! command -v task >/dev/null 2>&1; then
  echo "Installing go-task..." >&2
  sh -c "$(curl -sSL https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin \
    || echo "Warning: could not install go-task (check network)" >&2
fi

# Install Ruby gems for tests-cli
echo "Installing tests-cli gems..." >&2
(cd "$REPO/tests-cli" && bundle install --quiet) \
  || echo "Warning: tests-cli bundle install failed" >&2

# Install Ruby gems for tests-cpp (cucumber-wire runner)
echo "Installing tests-cpp gems..." >&2
(cd "$REPO/tests-cpp" && bundle install --quiet) \
  || echo "Warning: tests-cpp bundle install failed" >&2

# Install npm packages for tests-js
echo "Installing tests-js npm packages..." >&2
(cd "$REPO/tests-js" && npm install --silent) \
  || echo "Warning: tests-js npm install failed" >&2

echo "Session setup complete." >&2
