#!/usr/bin/env bash
set -euo pipefail

DIR="${1:-./summaries}"
OUT="${2:-./index.html}"

cat > "$OUT" <<'HTML'
<!doctype html>
<html lang="en">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Meeting Summaries</title>
<h1>Meeting Summaries</h1>
<ul>
HTML

shopt -s nullglob
count=0

for f in $(printf '%s\n' "$DIR"/summary_*.md | sort -r); do
  b=${f##*/}              # e.g., summary_5168_City_Council_on_2025-02-05_330_PM.md
  t=${b#summary_}         # 5168_City_Council_on_2025-02-05_330_PM.md
  t=${t#*_}               # City_Council_on_2025-02-05_330_PM.md  (drop "5168_")
  t=${t%.md}              # City_Council_on_2025-02-05_330_PM
  t=${t//_/ }             # City Council on 2025-02-05 330 PM

  href="${DIR#./}/$b"
  printf '  <li><a href="%s">%s</a></li>\n' "$href" "$t" >> "$OUT"
  count=$((count+1))
done

if [[ $count -eq 0 ]]; then
  printf '  <li><em>No summaries yet.</em></li>\n' >> "$OUT"
fi

cat >> "$OUT" <<'HTML'
</ul>
</html>
HTML

echo "Wrote $OUT with $count entries."

