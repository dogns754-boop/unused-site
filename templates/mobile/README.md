# __NAME__

__DESC__

## 휴대폰에서 바로 실행 (설치·빌드 없이)

1. 휴대폰에 **Expo Go** 앱 설치 (앱스토어/플레이스토어)
2. PC 에서:
   ```bash
   cd projects/__NAME__
   npm install
   npm start
   ```
3. 화면에 나온 QR 코드를 휴대폰으로 스캔

켜 둔 상태에서 코드를 **저장할 때마다 휴대폰 화면이 바로 바뀝니다** (새로고침 필요 없음).

## 구조

| 위치 | 내용 |
|---|---|
| `App.js` | 화면 |
| `src/logic/*.mjs` | 계산·규칙 (화면과 분리, `node --test` 로 테스트) |
| `test/` | 로직 테스트 |

## 테스트

```bash
scripts/check.sh __NAME__   # 저장소 루트에서
```

## 문서

- [기획서](PLAN.md) · [참고 자료](REFERENCES.md) · [변경 기록](CHANGELOG.md)
