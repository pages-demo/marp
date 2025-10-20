#!/usr/bin/env bash

set -e

SOURCE_DIR="./src"
OUTPUT_DIR="./dist"

# Clean and prepare output
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

echo "🎞️ Generating all slides from '$SOURCE_DIR'..."

# Step 1: Generate all HTML slides in-place under src/
npx @marp-team/marp-cli@latest "$SOURCE_DIR/**/*.md"

# Step 2: Move generated .html files to dist/
find "$SOURCE_DIR" -type f -name "*.html" | while read -r htmlfile; do
  relpath="${htmlfile#$SOURCE_DIR/}"      # e.g. talks/oop.html or intro/index.html
  relbase="${relpath%.html}"              # e.g. talks/oop or intro/index

  # If the file is named 'index.html', don't create an extra index/ directory
  if [[ "$relbase" == */index ]]; then
    outdir="$OUTPUT_DIR/${relbase%/index}"
    mkdir -p "$outdir"
    mv "$htmlfile" "$outdir/index.html"
    echo "🧩 Moved: $htmlfile → $outdir/index.html"
  else
    outdir="$OUTPUT_DIR/$relbase"
    mkdir -p "$outdir"
    mv "$htmlfile" "$outdir/index.html"
    echo "🧩 Moved: $htmlfile → $outdir/index.html"
  fi
done

echo "✅ All slides built successfully in '$OUTPUT_DIR'"
