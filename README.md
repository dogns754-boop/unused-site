# 보다 간단한 ○○ — 개인 프로그램 워크스페이스

기존 프로그램의 좋은 점은 살리고, 광고·무거움·불편함을 걷어낸 **나만의 간단한 프로그램**들을 Claude Code 와 함께 만드는 저장소입니다.

| 프로그램 | 플랫폼 | 한 줄 소개 |
|---|---|---|
| [simple-capture](projects/simple-capture/PLAN.md) | Windows | 캡처·녹화·GIF·텍스트 추출, 손잡이로 쉽게 잡는 범위 창 |
| [simple-pdf](projects/simple-pdf/PLAN.md) | Windows | 광고 없이 가벼운 PDF 보기 + 피그마식 전체 페이지 팔레트 |
| [simple-pill](projects/simple-pill/PLAN.md) | 휴대폰 | 약 복용 알림 + 지금 술 마셔도 되는지 |
| [simple-desk](projects/simple-desk/PLAN.md) | Windows | 바탕화면 바로가기 보관함 (탭·자유 배치·메모) |

진행 상황: [PROJECTS.md](PROJECTS.md) · 아이디어 수첩: [IDEAS.md](IDEAS.md)

> 👉 **처음이라면: [docs/START.md](docs/START.md)** — 설치부터 첫 작업까지 따라 하기

## 어떻게 쓰나 (Claude Code 에서)

```text
/idea 보다 간단한 ○○ — 이런저런 기능      ← 아이디어 적어 두기
/new-project simple-xxx windows "설명"    ← 시작하기
/spec simple-xxx                          ← 무엇을 만들지 정리
/research simple-xxx                      ← 비슷한 오픈소스 분석
/feature simple-xxx                       ← 기능 하나씩 만들기 (반복)
/wrap                                     ← 오늘 작업 마무리
```

자세한 설명: [docs/WORKFLOW.md](docs/WORKFLOW.md) · MCP 도구: [docs/MCP.md](docs/MCP.md) · **다른 컴퓨터에서 작업: [docs/NEW-PC.md](docs/NEW-PC.md)** · Claude 규칙: [CLAUDE.md](CLAUDE.md)

## 직접 실행

```bash
scripts/new-project.sh <이름> <windows|mobile|python|node|web> "설명"
scripts/check.sh [프로젝트]     # 테스트
scripts/status.sh               # 진행 현황
```

필요한 것: .NET 10 SDK (windows), Node.js 20+ (mobile/web/node), Python 3.10+ (python)

> 루트의 `index.html` 은 https://dogns754-boop.github.io/ 에 게시되는 안내 페이지입니다.
