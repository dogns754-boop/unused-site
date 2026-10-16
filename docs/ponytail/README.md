# Ponytail (가져온 규칙)

- 출처: https://github.com/DietrichGebert/ponytail — **v5.2.0** (커밋 2961b52), MIT 라이선스 ([LICENSE](LICENSE))
- 하는 일: "게으른 시니어 개발자" 규칙 — 꼭 필요한 만큼만, 가장 짧고 확실한 코드. 단 검증·오류 처리·보안·테스트는 절대 줄이지 않음.
- 가져온 것:
  - `RULES.md` — 원본 `AGENTS.md`. CLAUDE.md 가 불러와서 **항상 적용**됨
  - `.claude/skills/ponytail*/` — 명령어 4개 (`/ponytail`, `/ponytail-review`, `/ponytail-audit`, `/ponytail-debt`)
- 플러그인 대신 파일로 넣은 이유: 클라우드 세션에서는 플러그인이 켜지지 않기 때문. 파일로 넣으면 어디서나 똑같이 동작함.
- 업데이트: 원본 저장소의 새 버전에서 위 파일들을 다시 복사하고 이 문서의 버전을 고친다.
