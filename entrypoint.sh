#!/bin/bash
set -e

curl -o actions-runner.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf actions-runner.tar.gz \
    && rm actions-runner.tar.gz

# Config the runner
if [ ! -f .runner ]; then
  ./config.sh \
    --unattended \
    --name "${RUNNER_NAME}" \
    --url "${RUNNER_REPO}" \
    --token "${RUNNER_TOKEN}" \
    --work "_work"
fi

# Trap shutdown signals
cleanup() {
  echo "Removing runner..."
  ./config.sh remove --unattended --token "${RUNNER_TOKEN}"
  exit 0
}

trap 'cleanup' SIGINT SIGTERM

# Start the runner
./run.sh
