#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHEZMOI_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/output"

# Create output directory for logs
mkdir -p "$OUTPUT_DIR"

echo "Building test container..."
docker build -t chezmoi-test "$SCRIPT_DIR"

echo ""
echo "Running chezmoi installation test..."
echo "Mounting: $CHEZMOI_ROOT -> /chezmoi-source"
echo "Output: $OUTPUT_DIR"
echo ""

docker run --rm -i \
    -v "$CHEZMOI_ROOT:/chezmoi-source:ro" \
    -v "$SCRIPT_DIR/test-install.sh:/home/testuser/test-install.sh:ro" \
    -v "$OUTPUT_DIR:/output" \
    chezmoi-test \
    bash /home/testuser/test-install.sh

echo ""
echo "Test complete!"
echo "Logs saved to: $OUTPUT_DIR/"
