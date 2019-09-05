#!/bin/bash

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo "Deleting cmake build directories..."
rm -rf "${DIR}"/cmake-build-*

echo "Done!"
