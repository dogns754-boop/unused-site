# 처음 시작하기 — 영상으로만 봤던 걸 직접 해 보기

이 문서는 **아무것도 모르는 상태**에서 시작한다고 가정합니다. 위에서부터 순서대로 따라 하세요.
막히면 그 화면을 캡처해서 Claude 에게 보여주면 됩니다.

---

## 0. 용어 다섯 개만

| 용어 | 뜻 |
|---|---|
| **Claude Code** | 대화로 프로그램을 만들어 주는 Claude. 파일을 직접 만들고 고치고 실행까지 함 |
| **저장소 (repository)** | 프로젝트 파일 전체를 담은 폴더. GitHub 에 올려 두면 어디서나 받을 수 있음 |
| **커밋 / 푸시 / 풀** | 커밋 = 저장 지점 만들기, 푸시 = GitHub 에 올리기, 풀 = GitHub 에서 받아오기 |
| **슬래시 명령** | 입력창에 `/` 로 시작하는 명령. 예: `/feature`, `/wrap` |
| **MCP · 플러그인** | Claude 에게 끼워 주는 추가 도구 ([MCP.md](MCP.md)) |

---

## 1. 어디서 할지 고르기

| | 이렇게 시작 | 언제 |
|---|---|---|
| **A. 클라우드** (설치 없음) | 브라우저로 https://claude.ai/code → 저장소 `unused-site` 선택 | 기획, 로직, 아이디어 정리. 지금 이 대화가 바로 이 방식 |
| **B. 내 PC** | 아래 2번을 한 번 해 두기 | 만든 프로그램을 **직접 띄워 보며** 다듬을 때 |

처음엔 **A 로 충분**합니다. 캡처 프로그램 화면을 만들 때쯤 B 를 준비하면 됩니다.

---

## 2. 내 PC 준비 (B 를 쓸 때, 처음 한 번만 · 약 20분)

### 2-1. PowerShell 열기
`시작` 버튼 → `powershell` 입력 → **Windows PowerShell** 클릭. 파란/검은 창이 뜨면 성공.
(여기에 아래 명령을 **복사 → 붙여넣기(마우스 오른쪽 클릭) → Enter** 하면 됩니다)

### 2-2. 저장소 받기
```powershell
winget install --id Git.Git -e
```
설치가 끝나면 **PowerShell 창을 닫고 다시 열고**:
```powershell
cd ~\Documents
git clone https://github.com/dogns754-boop/unused-site.git
cd unused-site
git checkout claude/practical-pasteur-cgbaxa
```
GitHub 로그인 창이 뜨면 로그인하세요.

### 2-3. 도구 한 번에 설치
```powershell
powershell -ExecutionPolicy Bypass -File scripts\setup-windows.ps1
```
- 중간에 "설치하시겠습니까?" 같은 창이 뜨면 **예**.
- 끝나면 **PowerShell 을 닫았다 다시 열고, 같은 폴더로 가서(`cd ~\Documents\unused-site`) 한 번 더 실행**하세요. 두 번째에 Claude 플러그인까지 마무리됩니다.

### 2-4. Claude Code 열기
- **추천: Claude 데스크톱 앱** (https://claude.ai/download) → 로그인 → 왼쪽 **Code** 탭 → 폴더 열기 → `Documents\unused-site`
- 또는 PowerShell 에서 저장소 폴더로 가서 `claude` 입력

---

## 3. 처음 열면 나오는 질문들 — 이렇게 누르세요

| 화면에 나오는 말 | 누를 것 | 왜 |
|---|---|---|
| "Do you trust the files in this folder?" (이 폴더를 신뢰합니까) | **Yes** | 우리 저장소라서 안전 |
| "Use MCP servers from .mcp.json?" / `rea`, `context7` 허용 | **Yes / 모두 허용** | 공통 도구 켜기 |
| Claude 가 명령을 실행하려 할 때 "Allow?" | 내용을 보고 **Yes** (자주 쓰는 건 미리 허용해 둠) | 파일 수정·실행 허락 |
| Figma 를 쓰고 싶을 때 | 입력창에 `/mcp` → `figma` → **Authenticate** → 브라우저에서 **Allow Access** | 피그마 계정 연결 (한 번만) |

> 모르는 질문이 나오면 **누르기 전에** 그 화면을 캡처해서 Claude 에게 "이거 뭐야?" 라고 물어보세요.

---

## 4. 첫 작업 해 보기 (어디서든 똑같음)

입력창에 한 줄씩 넣고 Claude 의 답을 기다리면 됩니다.

```text
/projects
```
→ 프로젝트 4개의 진행 상황과 다음 할 일이 나옵니다.

```text
/feature simple-capture
```
→ 캡처 프로그램의 다음 기능("빠른 이름 짓기")을 만듭니다. Claude 가 계획을 보여주면 **"좋아, 진행해"** 라고 답하세요.

```text
/wrap
```
→ 오늘 작업을 정리하고 GitHub 에 올립니다. **자리를 뜨기 전에 꼭.**

### 자주 쓰는 말 (명령어 대신 그냥 말해도 됩니다)

| 하고 싶은 것 | 이렇게 말하기 |
|---|---|
| 새 아이디어 적어 두기 | `/idea 보다 간단한 ○○ — 이런 기능` |
| 만든 걸 써 보고 싶다 | "지금까지 만든 캡처 프로그램 exe 어떻게 받아?" |
| 고장 났다 | `/fix simple-capture 캡처 버튼 누르면 꺼짐` (+ 오류 화면 캡처) |
| 코드가 괜찮은지 | `/ponytail-review` |
| 디자인 참고 | 피그마 링크를 붙여넣고 "이 화면처럼 만들어 줘" |
| 다른 프로그램 분석 | "픽픽 범위 캡처가 어떻게 동작하는지 REA 로 분석해 줘" (내 PC 에서) |

---

## 5. 만든 프로그램 써 보기

- **PC 프로그램**: GitHub 저장소 → **Actions** 탭 → 맨 위 초록 ✅ 항목 → 아래 **windows-apps** 다운로드 → 압축 풀고 `simple-capture.exe` 더블클릭
  (처음엔 ".NET 런타임 설치" 안내가 뜰 수 있음 → 설치 → 다시 실행)
- **휴대폰 앱**: 휴대폰에 **Expo Go** 설치 → Claude 에게 "약 타이머 휴대폰에서 열어보고 싶어" 라고 하면 안내해 줌

---

## 6. 문제가 생기면

| 증상 | 해결 |
|---|---|
| 푸시가 안 된다 (403) | GitHub → Settings → Applications → Claude → **Configure** → 저장소 접근에 `unused-site` 추가 → Save |
| 다른 PC 에서 한 작업이 안 보인다 | 그쪽에서 `/wrap` 했는지 확인 → 이쪽에서 "pull 해줘" |
| 명령어가 안 먹는다 | 저장소 폴더(`unused-site`)에서 Claude Code 를 열었는지 확인 |
| 그 외 | 화면 캡처 + "이거 왜 이래?" |
