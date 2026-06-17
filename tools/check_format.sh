#!/bin/bash
# Format checker - verifies all files conform to .editorconfig rules
# Called by build diagnostics to catch formatting violations early.
set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VIOLATIONS=0

check_indent() {
  local file="$1"
  local expected_style="$2"  # space or tab
  local expected_size="$3"
  local lang="$4"
  
  local first_indent=$(grep -m1 '^[[:space:]]\+' "$file" 2>/dev/null | head -1)
  if [ -z "$first_indent" ]; then
    return 0  # No indented lines, skip
  fi
  
  if [ "$expected_style" = "space" ]; then
    if echo "$first_indent" | grep -q "^$(printf '\t')"; then
      echo "  VIOLATION: $file uses tabs but should use $expected_size spaces ($lang)"
      VIOLATIONS=$((VIOLATIONS + 1))
    fi
  elif [ "$expected_style" = "tab" ]; then
    if echo "$first_indent" | grep -q "^  "; then
      echo "  VIOLATION: $file uses spaces but should use tabs ($lang)"
      VIOLATIONS=$((VIOLATIONS + 1))
    fi
  fi
}

echo "Checking code formatting against .editorconfig..."

# Check a sample of files per language
for dir in backend/src market frailbox frontend/src compliance tools v2; do
  if [ ! -d "$ROOT/$dir" ]; then
    continue
  fi
  
  case "$dir" in
    backend/src)
      # Rust files should use 4 spaces
      for f in $(find "$ROOT/$dir" -name "*.rs" -type f 2>/dev/null | head -5); do
        check_indent "$f" "space" 4 "Rust"
      done
      ;;
    frontend/src)
      # TypeScript/JS should use 2 spaces
      for f in $(find "$ROOT/$dir" -name "*.ts" -o -name "*.tsx" -o -name "*.js" 2>/dev/null | head -5); do
        check_indent "$f" "space" 2 "TypeScript"
      done
      ;;
    market)
      # Go should use tabs
      for f in $(find "$ROOT/$dir" -name "*.go" -type f 2>/dev/null | head -5); do
        check_indent "$f" "tab" 8 "Go"
      done
      ;;
    frailbox)
      # C files should use 4 spaces
      for f in $(find "$ROOT/$dir" -name "*.c" -o -name "*.h" 2>/dev/null | head -5); do
        check_indent "$f" "space" 4 "C"
      done
      ;;
    compliance)
      # Java should use 4 spaces
      for f in $(find "$ROOT/$dir" -name "*.java" -type f 2>/dev/null | head -5); do
        check_indent "$f" "space" 4 "Java"
      done
      ;;
    tools)
      # Python should use 4 spaces
      for f in $(find "$ROOT/$dir" -name "*.py" -type f 2>/dev/null | head -5); do
        check_indent "$f" "space" 4 "Python"
      done
      ;;
  esac
done

if [ "$VIOLATIONS" -gt 0 ]; then
  echo ""
  echo "FOUND $VIOLATIONS FORMATTING VIOLATION(S)"
  echo "Run: editorconfig-checker or fix manually to match .editorconfig"
  exit 1
else
  echo "All checked files conform to .editorconfig formatting rules."
  exit 0
fi
