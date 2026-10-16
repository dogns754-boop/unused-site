#!/usr/bin/env bash
# 프로젝트별 상태와 기획서 체크리스트 진행률을 보여준다.
# 사용법: scripts/status.sh [--brief]
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
brief=0; [[ "${1:-}" == "--brief" ]] && brief=1

shopt -s nullglob
dirs=("$ROOT"/projects/*/)
if [[ ${#dirs[@]} -eq 0 ]]; then
  echo "[워크스페이스] 아직 프로젝트가 없습니다. /new-project <이름> <유형> 으로 시작하세요."
  exit 0
fi

echo "[워크스페이스] 프로젝트 ${#dirs[@]}개"
for d in "${dirs[@]}"; do
  name="$(basename "$d")"
  plan="$d/PLAN.md"
  status="?"; done_n=0; todo_n=0; next=""
  if [[ -f "$plan" ]]; then
    status="$(grep -m1 '^- 상태:' "$plan" | sed 's/^- 상태: *//')"
    done_n="$(grep -c '^\s*- \[[xX]\]' "$plan")"
    todo_n="$(grep -c '^\s*- \[ \]' "$plan")"
    next="$(grep -m1 '^\s*- \[ \]' "$plan" | sed 's/^\s*- \[ \] *//')"
  fi
  total=$((done_n + todo_n))
  line="- $name: ${status:-?} | 기능 $done_n/$total"
  [[ -n "$next" ]] && line+=" | 다음: $next"
  if [[ $brief -eq 0 ]]; then
    last="$(git -C "$ROOT" log -1 --format='%cs %s' -- "projects/$name" 2>/dev/null)"
    [[ -n "$last" ]] && line+=$'\n'"    최근 커밋: $last"
  fi
  echo "$line"
done
