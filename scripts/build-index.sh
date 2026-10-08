#!/usr/bin/env bash
# Kiểm tra thư mục ideas/ rồi dựng trang chủ vào _site/.
# Chạy: bash scripts/build-index.sh
set -eu
cd "$(dirname "$0")/.."
shopt -s nullglob dotglob

if [ ! -d ideas ]; then
  echo "LỖI: không tìm thấy thư mục 'ideas'" >&2
  exit 1
fi

errors=0
err() { echo "LỖI: $1" >&2; errors=$((errors + 1)); }

slugs=()
for path in ideas/*; do
  name=${path#ideas/}
  if [ ! -d "$path" ]; then
    [ "$name" = ".gitkeep" ] && continue
    err "tệp 'ideas/$name' nằm trực tiếp trong ideas/ — mọi tệp phải nằm bên trong một thư mục ý tưởng (ví dụ ideas/ten-y-tuong/$name)"
    continue
  fi
  ok=1
  if ! [[ $name =~ ^[a-z0-9-]+$ ]]; then
    err "thư mục '$path' — tên chỉ được dùng chữ thường không dấu, số, dấu gạch ngang (ví dụ: may-tinh-luong)"
    ok=0
  fi
  if [ ! -f "$path/index.html" ]; then
    err "thư mục '$path' — thiếu tệp index.html (tệp này phải nằm ngay trong thư mục, không nằm trong thư mục con)"
    ok=0
  fi
  [ "$ok" = 1 ] && slugs+=("$name")
done

if [ "$errors" -gt 0 ]; then
  echo "Có $errors lỗi. Hãy sửa các lỗi trên rồi tải lên lại." >&2
  exit 1
fi

# In ra nội dung thẻ <title> đầu tiên (không phân biệt hoa thường, cho phép xuống dòng).
get_title() {
  local content lower prefix rest rest_lower inner
  content=$(tr '\r\n\t' '   ' < "$1")
  lower=$(printf '%s' "$content" | LC_ALL=C tr '[:upper:]' '[:lower:]')
  prefix=${lower%%<title*}
  [ "$prefix" = "$lower" ] && return 0
  rest=${content:${#prefix}}
  rest=${rest#*>}
  rest_lower=$(printf '%s' "$rest" | LC_ALL=C tr '[:upper:]' '[:lower:]')
  inner=${rest_lower%%</title*}
  [ "$inner" = "$rest_lower" ] && return 0
  printf '%s' "${rest:0:${#inner}}" | tr -s ' ' | sed 's/^ //; s/ $//'
}

# Giải mã các thực thể HTML có sẵn trong <title> (&amp; giải mã sau cùng) rồi mã hoá lại, tránh mã hoá hai lần.
escape_html() {
  printf '%s' "$1" | sed "s/&lt;/</g; s/&gt;/>/g; s/&quot;/\"/g; s/&#0\{0,1\}39;/'/g; s/&amp;/\&/g;
    s/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/\"/\&quot;/g; s/'/\&#39;/g"
}

rm -rf _site
mkdir _site
cp -r ideas _site/ideas
cp huong-dan.html _site/

cards=""
for slug in "${slugs[@]+"${slugs[@]}"}"; do
  title=$(get_title "ideas/$slug/index.html")
  [ -n "$title" ] || title=$slug
  cards+="      <a class=\"card\" href=\"ideas/$slug/\"><span class=\"title\">$(escape_html "$title")</span><span class=\"slug\">$slug</span></a>
"
done

count=${#slugs[@]}
if [ "$count" -eq 0 ]; then
  body='    <p class="empty">Chưa có ý tưởng nào. Hãy là người đầu tiên!</p>'
else
  body="    <p class=\"count\">$count ý tưởng</p>
    <div class=\"grid\">
$cards    </div>"
fi

cat > _site/index.html <<EOF
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Ý tưởng — Scratch Projects</title>
  <style>
    * { box-sizing: border-box; }
    body { margin: 0; font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif; background: #f5f6f8; color: #1f2328; }
    main { max-width: 1100px; margin: 0 auto; padding: 32px 16px; }
    h1 { margin: 0 0 4px; }
    .count, .empty { color: #59636e; }
    .guide a { display: inline-block; margin: 8px 0 4px; padding: 10px 16px; background: #1f883d; color: #fff; border-radius: 8px; text-decoration: none; font-weight: 600; }
    .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 16px; }
    .card { display: flex; flex-direction: column; gap: 8px; padding: 20px; background: #fff; border: 1px solid #d1d9e0; border-radius: 12px; color: inherit; text-decoration: none; transition: box-shadow .15s, transform .15s; }
    .card:hover, .card:focus-visible { box-shadow: 0 6px 18px rgba(0,0,0,.08); transform: translateY(-2px); }
    .title { font-weight: 600; font-size: 1.1rem; overflow-wrap: anywhere; }
    .slug { color: #59636e; font-size: .85rem; font-family: ui-monospace, monospace; }
  </style>
</head>
<body>
  <main>
    <h1>Ý tưởng — Scratch Projects</h1>
    <p class="guide"><a href="huong-dan.html">📘 Có ý tưởng? Xem hướng dẫn đăng lên tại đây, không cần biết code</a></p>
$body
  </main>
</body>
</html>
EOF

echo "Đã dựng _site/index.html với $count ý tưởng."
