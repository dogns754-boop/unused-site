#!/usr/bin/env bash
# 개발 도구 준비. 클라우드 세션에서는 세션 시작 때 자동 실행된다.
# - 공통 MCP 도구(tools/, REA 등) 설치
# - .NET SDK 가 없고 apt 를 쓸 수 있으면 설치 (windows 유형 프로젝트 테스트용)
# 사용법: scripts/setup.sh          (클라우드에서는 자동, 내 PC 에서는 --force)
set -uo pipefail

if [[ "${CLAUDE_CODE_REMOTE:-}" != "true" && "${1:-}" != "--force" ]]; then
  exit 0   # 내 PC 에서는 아무것도 하지 않음 (필요하면 --force)
fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
if [[ -f "$ROOT/tools/package.json" && ! -d "$ROOT/tools/node_modules" ]] && command -v npm >/dev/null 2>&1; then
  (cd "$ROOT/tools" && npm install --no-audit --no-fund --silent) >/dev/null 2>&1 \
    && echo "[setup] 공통 MCP 도구(tools/) 준비됨" \
    || echo "[setup] 공통 MCP 도구 설치 실패 — 'cd tools && npm install' 을 직접 실행하세요"
fi
if compgen -G "$ROOT/projects/*/*.sln" >/dev/null && ! command -v dotnet >/dev/null 2>&1; then
  if command -v apt-get >/dev/null 2>&1; then
    echo "[setup] .NET SDK 설치 중…"
    (apt-get update -qq && apt-get install -y -qq dotnet-sdk-10.0) >/dev/null 2>&1 \
      && echo "[setup] .NET $(dotnet --version) 준비됨" \
      || echo "[setup] .NET 설치 실패 — windows 프로젝트 테스트는 건너뜁니다"
  fi
fi
exit 0
