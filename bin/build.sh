#!/bin/bash
set -e

# Build the Jekyll site
bundle exec jekyll build

# Manually copy uploads and filter large files for Cloudflare Pages (25MB limit)
echo "Copying uploads..."
mkdir -p _site/uploads
cp -r _uploads/* _site/uploads/

echo "Filtering large files..."
# Remove the known 26MB file
rm -f "_site/uploads/Contract - Tuesday at 1-47 PM.m4a"
# Remove other potentially large media types
find _site/uploads -type f \( -name "*.mp4" -o -name "*.m4a" -o -name "*.PEF" -o -name "*.pef" \) -delete

echo "Build complete."
ls -la _site
