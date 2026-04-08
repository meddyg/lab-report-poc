#!/bin/bash

##
# build-ig.sh
# Complete IG build workflow: SUSHI → XHTML lang attribute injection
#
# Usage:
#   bash _scripts/build-ig.sh
#   bash _scripts/build-ig.sh --skip-xhtml  # Only run sushi, skip XHTML enhancement
#
# Exit codes:
#   0 = Success (sushi && python)
#   1 = SUSHI failed
#   2 = Python script failed
##

set -e  # Exit on first error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🏗️  IG Build Workflow${NC}"
echo "Project: $PROJECT_ROOT"
echo ""

# Step 1: SUSHI Build
echo -e "${YELLOW}Step 1: Running SUSHI...${NC}"
cd "$PROJECT_ROOT"

if ! command -v sushi &> /dev/null; then
    echo -e "${RED}❌ Error: sushi not found. Install with: npm install -g fsh-sushi${NC}"
    exit 1
fi

if sushi build; then
    echo -e "${GREEN}✅ SUSHI completed successfully${NC}"
else
    echo -e "${RED}❌ SUSHI failed${NC}"
    exit 1
fi

echo ""

# Step 2: Check if we should skip XHTML enhancement
if [ "$1" == "--skip-xhtml" ]; then
    echo -e "${YELLOW}Skipping XHTML enhancement (--skip-xhtml flag set)${NC}"
    exit 0
fi

# Step 2: Python Post-Processing
echo -e "${YELLOW}Step 2: Enhancing XHTML narratives...${NC}"

if ! command -v python3 &> /dev/null; then
    echo -e "${RED}❌ Error: python3 not found${NC}"
    exit 2
fi

if python3 "$SCRIPT_DIR/add-lang-to-xhtml.py"; then
    echo -e "${GREEN}✅ XHTML enhancement completed${NC}"
else
    echo -e "${RED}❌ XHTML enhancement failed${NC}"
    exit 2
fi

echo ""
echo -e "${GREEN}🎉 Complete build workflow finished successfully${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  - Review changes: git diff fsh-generated/"
echo "  - Commit: git add fsh-generated/ && git commit -m 'Generated IG resources'"
echo "  - Validate: python3 validate_examples.py (optional)"
