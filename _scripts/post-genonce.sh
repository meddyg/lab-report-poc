#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

echo "Running IG Publisher via _genonce.sh..."
./_genonce.sh "$@"

echo
echo "Applying XHTML lang/xml:lang post-processing..."
python3 "$SCRIPT_DIR/add-lang-to-xhtml.py" output output/es

echo
echo "Done. output/ and output/es/ were post-processed."