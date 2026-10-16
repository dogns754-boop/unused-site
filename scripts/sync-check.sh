#!/usr/bin/env bash
# 여러 컴퓨터에서 작업할 때: 다른 곳에서 올린 새 작업이 있는지, 여기서 안 올린 작업이 있는지 알려준다.
# 세션 시작 시 자동 실행 (.claude/settings.json). 네트워크가 느리면 조용히 넘어간다.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 0
branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" || exit 0
upstream="$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)" || {
  echo "[동기화] '$branch' 브랜치가 GitHub 와 연결되어 있지 않습니다 (git push -u origin $branch 필요)."
  exit 0
}
timeout 10 git fetch --quiet origin "${upstream#origin/}" 2>/dev/null || exit 0
behind="$(git rev-list --count HEAD.."$upstream" 2>/dev/null || echo 0)"
ahead="$(git rev-list --count "$upstream"..HEAD 2>/dev/null || echo 0)"
dirty="$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')"
[[ "$behind" -gt 0 ]] && echo "[동기화] ⬇️ 다른 컴퓨터에서 올린 새 커밋 ${behind}개 — 작업 전에 'git pull' 하세요."
[[ "$ahead"  -gt 0 ]] && echo "[동기화] ⬆️ 아직 GitHub 에 안 올린 커밋 ${ahead}개 — 다른 컴퓨터에서 이어 하려면 'git push' 하세요."
[[ "$dirty"  -gt 0 ]] && echo "[동기화] ✏️ 커밋하지 않은 변경 ${dirty}개가 있습니다."
exit 0
