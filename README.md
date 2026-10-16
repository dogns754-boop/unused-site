# 개인 프로그램 개발 워크스페이스

여러 개의 개인 프로그램을 Claude Code 와 함께 만들고 관리하는 저장소입니다.

- 프로젝트 목록: [PROJECTS.md](PROJECTS.md)
- 개발 흐름: [docs/WORKFLOW.md](docs/WORKFLOW.md)
- Claude 가 따르는 규칙: [CLAUDE.md](CLAUDE.md)

## 빠른 시작 (Claude Code 에서)

```text
/new-project todo-cli python "터미널 할 일 관리"
/spec todo-cli
/feature todo-cli
/wrap
```

## 직접 실행

```bash
scripts/new-project.sh <이름> <python|node|web> "설명"   # 프로젝트 생성
scripts/check.sh [프로젝트]                               # 테스트
scripts/status.sh                                         # 진행 현황
```

필요한 것: Python 3.10+, Node.js 20+ (외부 패키지 없이 동작합니다).

> 루트의 `index.html` 은 https://dogns754-boop.github.io/ 에 게시되는 안내 페이지입니다.
