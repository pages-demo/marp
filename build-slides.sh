#!/usr/bin/env bash

set -e

SOURCE_DIR="./src"
OUTPUT_DIR="./dist"

# Clean previous build
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# Find all markdown files recursively in ./src
find "$SOURCE_DIR" -type f -name "*.md" | while read -r file; do
  # Get relative path inside src/ (e.g. intro.md or subdir/lecture.md)
  relpath="${file#$SOURCE_DIR/}"
  relbase="${relpath%.md}"

  # Create output directory like: dist/intro/
  outdir="$OUTPUT_DIR/$relbase"
  mkdir -p "$outdir"

  echo "🎞️  Generating $outdir/index.html"
  npx -y @marp-team/marp-cli@latest "$file" -o "$outdir/index.html" --html --allow-local-files
done

echo "✅ All slides built successfully into '$OUTPUT_DIR'"

