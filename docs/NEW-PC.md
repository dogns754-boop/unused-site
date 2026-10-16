# 다른 컴퓨터에서 작업하기

모든 작업은 **GitHub 저장소**에 모입니다. 어느 컴퓨터에서든 GitHub 에서 받아 와서 작업하고, 끝나면 다시 올리면 이어서 할 수 있습니다.
규칙·명령어(`/feature` 등)·MCP 설정도 저장소 안에 있어서 **어디서 열든 똑같이** 동작합니다.

```
   집 PC ──┐                 ┌── 회사 PC
           ├── GitHub 저장소 ─┤
 클라우드 ─┘   (모든 작업)    └── 노트북
```

## 방법 1. 클라우드 — 설치 없이 아무 컴퓨터에서 (가장 간단)

1. 브라우저에서 **https://claude.ai/code** 접속 → 로그인
2. 저장소 `dogns754-boop/unused-site` 선택 → 대화 시작
3. 끝나면 `/wrap` (자동으로 GitHub 에 올림)

- 좋은 점: 설치할 것 없음, PC 를 꺼도 작업이 계속됨, 휴대폰으로도 확인 가능
- 한계: 리눅스 환경이라 **PC 프로그램 화면을 띄워 볼 수 없음** → 로직·기획·문서 작업에 적합

## 방법 2. 내 PC — 화면을 보면서 다듬을 때

### 처음 한 번만 (새 PC 준비)

1. **저장소 받기** — PowerShell 을 열고:
   ```powershell
   winget install --id Git.Git -e
   # PowerShell 창을 닫았다 다시 열고:
   cd ~\Documents
   git clone https://github.com/dogns754-boop/unused-site.git
   cd unused-site
   git checkout claude/practical-pasteur-cgbaxa
   ```
2. **도구 한 번에 설치** — 같은 창에서:
   ```powershell
   powershell -ExecutionPolicy Bypass -File scripts\setup-windows.ps1
   ```
   Git, .NET 10 SDK, Node.js, Python, Claude Code, MCP 도구, Claude 플러그인을 설치합니다 (이미 있으면 건너뜀).
   **처음에는 PowerShell 을 다시 열고 한 번 더 실행**하세요 — 새로 깐 도구로 남은 설치를 마무리합니다.
3. **Claude Code 열기** — 둘 중 편한 것:
   - Claude **데스크톱 앱** → Code 탭 → `unused-site` 폴더 열기 (추천: 화면 보기 기능 사용 가능)
   - PowerShell 에서 저장소 폴더로 가서 `claude`

### 매번 작업할 때

| 언제 | 할 일 |
|---|---|
| 시작할 때 | Claude 가 세션 시작 때 "⬇️ 새 커밋 N개" 를 알려주면 → **"pull 해줘"** |
| 끝날 때 | **`/wrap`** — 검사·정리 후 GitHub 에 올림 |

> ⚠️ **올리지 않고 다른 컴퓨터로 가면 그 작업은 따라오지 않습니다.** 자리를 뜨기 전에 꼭 `/wrap`.

## 어떤 걸 쓸까?

| 하고 싶은 일 | 추천 |
|---|---|
| 아이디어 정리, 기획서, 로직(계산) 기능 | 클라우드 또는 아무 PC |
| PC 프로그램 화면 만들기·다듬기 (캡처 창, PDF 화면…) | **내 PC** (실행해서 바로 확인) |
| 휴대폰 앱 화면 | 내 PC + 휴대폰 Expo Go |
| 밖에서 잠깐 진행 상황 확인 | 클라우드 (휴대폰 브라우저도 됨) |

## 컴퓨터마다 따로인 것

- `.claude/settings.local.json` — 그 컴퓨터에서만 쓰는 개인 설정 (GitHub 에 안 올라감)
- `references/` — `/research` 로 받은 참고용 코드 (필요하면 다시 받으면 됨)
- `bin/`, `obj/`, `node_modules/` — 빌드 결과물 (자동으로 다시 만들어짐)
