# 개발 워크플로

Claude Code 로 "보다 간단한 ○○" 프로그램들을 만드는 흐름입니다. 모든 명령은 Claude Code 입력창에 그대로 입력합니다.

## 큰 그림

```
┌ 상위 (워크스페이스) ─────────────────────────────────────────┐
│  CLAUDE.md 규칙 · .mcp.json 도구 · IDEAS.md 아이디어 수첩     │
│  /idea /new-project /projects  · templates · scripts · CI     │
├ 하위 (프로그램별) ───────────────────────────────────────────┤
│  projects/simple-capture   projects/simple-pdf                │
│  projects/simple-pill      projects/simple-desk   …           │
│  각자 PLAN.md · REFERENCES.md · 코드 · 테스트                 │
└───────────────────────────────────────────────────────────────┘
```

## 한눈에 보기

```
 💡 아이디어 ── /idea "보다 간단한 ○○ …" ──▶ IDEAS.md 에 정리
    │  /new-project simple-xxx windows "설명"
    ▼
 🌱 기획 ─── /spec simple-xxx ─────▶ PLAN.md 에 기능 체크리스트 완성
    │         /research simple-xxx ─▶ 비슷한 오픈소스 분석 (REFERENCES.md)
    ▼
 🔨 개발 ─── /feature simple-xxx ──▶ 테스트 → 구현 → 정리 → 커밋 (기능 1개씩 반복)
    │         /fix simple-xxx "증상" (버그가 생기면)
    │         /check simple-xxx     (언제든 검사)
    ▼
 세션 끝 ── /wrap ──────────────▶ 리뷰 · 문서 정리 · 커밋 · 푸시
    │
    ▼
 ✅ 완성   (/projects 로 전체 현황 확인)
```

## 하루 작업 예시

```text
나:     /projects
Claude: simple-capture 🔨 개발 중 3/21, 다음: "메인 도구창" …

나:     /feature simple-capture
Claude: (계획 제시 → 실패하는 테스트 → 구현 → 검사 통과 → 체크박스 갱신 → 커밋)
        PC 에서 확인할 것: ① Actions 에서 exe 받기 ② 버튼 3개가 보이는지 …

나:     /idea 보다 간단한 메모장 — 탭이 있고 자동 저장되는
Claude: IDEAS.md 에 정리했어요. 바로 시작할까요?

나:     /wrap
Claude: 오늘 2개 기능 완료. 다음 세션: /feature simple-capture
```

## 만든 프로그램을 직접 써 보기

| 유형 | 방법 |
|---|---|
| windows | ① GitHub → **Actions** 탭 → 최근 실행 → 아래 **windows-apps** 다운로드 → 압축 풀고 exe 실행 (처음 한 번 .NET 데스크톱 런타임 설치 안내가 뜰 수 있음) <br> ② 또는 내 PC 에 .NET SDK 를 깔고 `dotnet run --project projects\<이름>\src\<이름>.App` |
| mobile | 휴대폰에 **Expo Go** 설치 → PC 에서 `cd projects/<이름> && npm install && npm start` → QR 스캔 |
| web | `cd projects/<이름> && npm start` → 브라우저에서 http://localhost:8000 |

> 클라우드 세션(웹의 Claude Code)은 Linux 라서 Windows 화면을 띄울 수 없습니다. 로직·빌드는 클라우드에서,
> 화면 다듬기는 **내 PC 의 Claude Code 데스크톱 앱**에서 하면 Claude 가 실제 화면을 보며 고칠 수 있습니다.

## 원칙

1. **기획 먼저** — 무엇을 만들지(PLAN.md) 정하기 전에 코드를 쓰지 않습니다.
2. **기능 하나씩** — `/feature` 한 번 = 체크박스 한 칸 = 커밋 하나.
3. **테스트 먼저** — 실패하는 테스트를 보고 나서 구현합니다.
4. **범위 지키기** — 하다가 떠오른 아이디어는 PLAN.md `나중에` 로 보냅니다.
5. **기록 남기기** — PLAN.md 작업 기록과 CHANGELOG 만 읽어도 어디까지 했는지 알 수 있게.

## 자동으로 되는 것

- **세션 시작 시** 프로젝트별 진행 상황이 Claude 에게 자동 전달됩니다 (`.claude/settings.json` 의 SessionStart 훅 → `scripts/status.sh --brief`).
- **자주 쓰는 명령**(테스트, git status/diff/commit 등)은 매번 허락을 묻지 않도록 허용되어 있습니다.
- **`.env` 같은 비밀 파일**은 읽지 않도록 막혀 있습니다.
- **GitHub 에 푸시하면** Actions 가 모든 프로젝트 테스트를 돌리고, windows 프로그램은 **exe 파일까지 만들어** 둡니다 (`.github/workflows/ci.yml`).
- **클라우드 세션 시작 시** windows 프로젝트용 .NET SDK 가 없으면 자동 설치합니다 (`scripts/setup.sh`).

## 확장하기

| 하고 싶은 것 | 방법 |
|---|---|
| 공통 MCP 도구 추가 | [docs/MCP.md](MCP.md) 참고 |
| 새 언어 템플릿 (Go, Rust 등) | `templates/<유형>/` 추가 + `scripts/check.sh` 에 감지 규칙 추가 |
| 나만의 명령 추가 | `.claude/skills/<이름>/SKILL.md` 작성 → `/<이름>` 으로 사용 |
| 내 컴퓨터에서만 쓸 설정 | `.claude/settings.local.json` (git 에 올라가지 않음) |
| 허용 명령 추가 | `.claude/settings.json` 의 `permissions.allow` |
