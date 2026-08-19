#!/usr/bin/env bash
# Pretendard 서브셋 재생성 (2026-08-19)
#
# 왜 self-host 인가:
#   jsDelivr 동적 서브셋은 한 페이지에 19개 요청 / 약 506KB 를 만든다.
#   여기서는 1개 요청 / 약 475KB · 동일 오리진 · 1년 캐시로 바꾼다.
#
# 왜 KS X 1001 전체를 넣는가:
#   본문에 실제로 쓰인 글자만 넣으면 184KB 까지 줄지만, 새 글에 없던 음절이
#   들어오면 **그 글자만 폴백 서체로 렌더**된다. 조용히 섞여서 알아채기 어렵다.
#   KS X 1001 상용 2,350음절을 넣어두면 일반적인 한국어 글은 전부 커버된다.
#   (2026-08-19 기준 본문 한글 657음절은 100% KS X 1001 안에 있었다)
#
# 필요: pip install fonttools brotli
set -euo pipefail
cd "$(dirname "$0")/.."

SRC=/tmp/PretendardVariable.woff2
curl -sSL -o "$SRC" \
  "https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/packages/pretendard/dist/web/variable/woff2/PretendardVariable.woff2"

python3 - <<'PY'
import glob
chars=set()
for pat in ('_posts/*.md','_pages/*.md','_includes/*.html','_layouts/*.html'):
    for f in glob.glob(pat):
        chars |= set(open(f,encoding='utf-8').read())
for f in ('_config.yml','_data/navigation.yml','_data/ui-text.yml','index.html'):
    chars |= set(open(f,encoding='utf-8').read())
# KS X 1001 상용 한글 2,350음절
for c in range(0xAC00,0xD7A4):
    ch=chr(c)
    try: ch.encode('iso2022_kr'); chars.add(ch)
    except UnicodeEncodeError: pass
chars={c for c in chars if c.isprintable() or c==' '}
open('/tmp/charset.txt','w',encoding='utf-8').write(''.join(sorted(chars)))
print(f'charset: {len(chars):,} chars')
PY

pyftsubset "$SRC" --text-file=/tmp/charset.txt \
  --flavor=woff2 --layout-features='*' --no-hinting \
  --output-file=assets/fonts/PretendardVariable.subset.woff2

ls -la assets/fonts/PretendardVariable.subset.woff2
