#!/usr/bin/env bash
# 프로젝트 테스트(+가능하면 린트)를 실행한다.
# 사용법: scripts/check.sh [프로젝트이름 ...]   (생략하면 전체)
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/projects" || exit 1

if [[ $# -gt 0 ]]; then
  targets=("$@")
else
  mapfile -t targets < <(find . -mindepth 1 -maxdepth 1 -type d ! -name '.*' -printf '%f\n' | sort)
fi

if [[ ${#targets[@]} -eq 0 ]]; then
  echo "검사할 프로젝트가 없습니다. /new-project 로 시작하세요."
  exit 0
fi

failed=()
for p in "${targets[@]}"; do
  p="${p#projects/}"; p="${p%/}"
  if [[ ! -d "$p" ]]; then
    echo "❌ $p: 프로젝트가 없습니다"; failed+=("$p"); continue
  fi
  echo "━━━ $p ━━━"
  ok=1
  if [[ -f "$p/pyproject.toml" ]]; then
    if command -v ruff >/dev/null 2>&1; then
      (cd "$p" && ruff check .) || ok=0
    fi
    if python3 -c 'import pytest' 2>/dev/null; then
      (cd "$p" && PYTHONPATH=src python3 -m pytest -q) || ok=0
    else
      (cd "$p" && PYTHONPATH=src python3 -m unittest discover -s tests -v) || ok=0
    fi
  elif [[ -f "$p/package.json" ]]; then
    if grep -q '"dependencies"\|"devDependencies"' "$p/package.json" && [[ ! -d "$p/node_modules" ]]; then
      (cd "$p" && npm install --no-audit --no-fund) || ok=0
    fi
    (cd "$p" && npm test --silent) || ok=0
  else
    echo "⚠️  $p: 유형을 알 수 없어 건너뜀 (pyproject.toml / package.json 없음)"
    continue
  fi
  if [[ $ok -eq 1 ]]; then echo "✅ $p 통과"; else echo "❌ $p 실패"; failed+=("$p"); fi
done

echo
if [[ ${#failed[@]} -gt 0 ]]; then
  echo "실패: ${failed[*]}"
  exit 1
fi
echo "모두 통과 (${#targets[@]}개)"
