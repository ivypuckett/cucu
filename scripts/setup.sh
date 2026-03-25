#!/usr/bin/env bash
# setup.sh — install all dependencies needed to build and test cucu
# Run once as root (or with sudo) before using `task` commands.
set -euo pipefail

# ── 1. Nim compiler ────────────────────────────────────────────────────────────
if ! command -v nim &>/dev/null; then
  echo "==> Installing nim..."
  apt-get install -y nim
else
  echo "==> nim already installed ($(nim --version | head -1))"
fi

# ── 2. Task CLI ────────────────────────────────────────────────────────────────
# taskfile.dev may be blocked in some environments; download direct from GitHub.
if ! command -v task &>/dev/null; then
  echo "==> Installing task CLI..."
  TASK_VERSION=$(curl -s https://api.github.com/repos/go-task/task/releases/latest \
    | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'])")
  curl -fL "https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_linux_amd64.tar.gz" \
    | tar -xzC /usr/local/bin task
  echo "==> task ${TASK_VERSION} installed"
else
  echo "==> task already installed ($(task --version))"
fi

# ── 3. C++ test dependencies ───────────────────────────────────────────────────
echo "==> Installing C++ build dependencies..."
apt-get install --fix-missing -y \
  libgtest-dev \
  nlohmann-json3-dev \
  libasio-dev \
  libtclap-dev \
  libboost-thread-dev \
  libboost-filesystem-dev \
  libboost-system-dev

# ── 4. cucumber-cpp ────────────────────────────────────────────────────────────
if [ -f /usr/local/lib/cmake/CucumberCppConfig.cmake ]; then
  echo "==> cucumber-cpp already installed"
else
  echo "==> Building and installing cucumber-cpp from source..."
  TMPDIR=$(mktemp -d)
  trap "rm -rf $TMPDIR" EXIT

  curl -fL https://codeload.github.com/cucumber/cucumber-cpp/tar.gz/refs/heads/main \
    -o "$TMPDIR/cucumbercpp.tar.gz"
  tar -xzf "$TMPDIR/cucumbercpp.tar.gz" -C "$TMPDIR"
  SRC="$TMPDIR/cucumber-cpp-main"

  # Patch out the git-describe version check (not needed for a plain build)
  cat > "$SRC/cmake/modules/GitVersion.cmake" <<'CMAKE'
function(git_get_version VERSION_VARIABLE)
    set(${VERSION_VARIABLE} "0.7.0" PARENT_SCOPE)
endfunction(git_get_version)
CMAKE

  cmake -B "$SRC/build" -S "$SRC" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCUKE_ENABLE_EXAMPLES=OFF \
    -DCUKE_ENABLE_TESTS=OFF \
    -DCUKE_ENABLE_GTEST=ON
  cmake --build "$SRC/build"
  cmake --install "$SRC/build"
  echo "==> cucumber-cpp installed"
fi

echo ""
echo "All dependencies installed. You can now run:"
echo "  task        # build all targets"
echo "  task test   # run all three test suites"
