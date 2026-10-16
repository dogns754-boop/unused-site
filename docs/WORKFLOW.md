# 개발 워크플로

Claude Code 로 개인 프로그램을 만드는 흐름입니다. 모든 명령은 Claude Code 입력창에 그대로 입력합니다.

## 한눈에 보기

```
 아이디어
    │  /new-project todo-cli python "터미널 할 일 관리"
    ▼
 🌱 기획 ─── /spec todo-cli ───▶ PLAN.md 에 기능 체크리스트 완성
    │
    ▼
 🔨 개발 ─── /feature todo-cli ─▶ 테스트 → 구현 → 정리 → 커밋 (기능 1개씩 반복)
    │         /fix todo-cli "증상" (버그가 생기면)
    │         /check todo-cli     (언제든 검사)
    ▼
 세션 끝 ── /wrap ──────────────▶ 리뷰 · 문서 정리 · 커밋 · 푸시
    │
    ▼
 ✅ 완성   (/projects 로 전체 현황 확인)
```

## 하루 작업 예시

```text
나:     /projects
Claude: todo-cli 🔨 개발 중 3/6, 다음: "완료 표시 명령" …

나:     /feature todo-cli
Claude: (계획 제시 → 실패하는 테스트 → 구현 → 검사 통과 → 체크박스 갱신 → 커밋)

나:     /feature todo-cli
…
나:     /wrap
Claude: 오늘 2개 기능 완료, 4/6 → 5/6. 다음 세션: /feature todo-cli
```

## 원칙

1. **기획 먼저** — 무엇을 만들지(PLAN.md) 정하기 전에 코드를 쓰지 않습니다.
2. **기능 하나씩** — `/feature` 한 번 = 체크박스 한 칸 = 커밋 하나.
3. **테스트 먼저** — 실패하는 테스트를 보고 나서 구현합니다.
4. **범위 지키기** — 하다가 떠오른 아이디어는 PLAN.md `3. 나중에` 로 보냅니다.
5. **기록 남기기** — PLAN.md 작업 기록과 CHANGELOG 만 읽어도 어디까지 했는지 알 수 있게.

## 자동으로 되는 것

- **세션 시작 시** 프로젝트별 진행 상황이 Claude 에게 자동 전달됩니다 (`.claude/settings.json` 의 SessionStart 훅 → `scripts/status.sh --brief`).
- **자주 쓰는 명령**(테스트, git status/diff/commit 등)은 매번 허락을 묻지 않도록 허용되어 있습니다.
- **`.env` 같은 비밀 파일**은 읽지 않도록 막혀 있습니다.
- **GitHub 에 푸시하면** Actions 가 모든 프로젝트 테스트를 돌립니다 (`.github/workflows/ci.yml`).

## 확장하기

| 하고 싶은 것 | 방법 |
|---|---|
| 새 언어 템플릿 (Go, Rust 등) | `templates/<유형>/` 추가 + `scripts/check.sh` 에 감지 규칙 추가 |
| 나만의 명령 추가 | `.claude/skills/<이름>/SKILL.md` 작성 → `/<이름>` 으로 사용 |
| 내 컴퓨터에서만 쓸 설정 | `.claude/settings.local.json` (git 에 올라가지 않음) |
| 허용 명령 추가 | `.claude/settings.json` 의 `permissions.allow` |
