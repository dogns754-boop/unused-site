# simple-capture

보다 간단한 캡처 — 캡처·녹화·GIF·텍스트 추출을 한 창에서

## 실행 (Windows)

```powershell
cd projects\simple-capture
dotnet watch --project src\SimpleCapture.App --non-interactive
```

`dotnet watch` 로 띄워 두면 **코드를 저장할 때마다 프로그램이 자동으로 새로 고쳐집니다** (웹사이트 새로고침처럼).
Claude 가 코드를 고치면 몇 초 뒤 화면에 바로 반영되니, 보면서 "이 버튼 더 크게" 처럼 말하면 됩니다. 끄려면 `Ctrl+C`.

설치 없이 써 보려면: GitHub → Actions → 최근 실행 → **windows-apps** 아티팩트에서 `simple-capture.exe` 다운로드
(처음 실행할 때 .NET 데스크톱 런타임 설치 안내가 뜨면 한 번만 설치)

## 구조

| 폴더 | 내용 | 어디서 테스트 |
|---|---|---|
| `src/SimpleCapture.Core` | 화면과 무관한 로직 (파일 이름 규칙, 설정, 계산 등) | 어디서나 (`dotnet test`) |
| `src/SimpleCapture.App` | WPF 화면, Windows API 호출 | Windows 에서 직접 실행 |
| `tests/SimpleCapture.Core.Tests` | Core 테스트 (xUnit) | 어디서나 |

## 테스트

```bash
scripts/check.sh simple-capture   # 저장소 루트에서
```

## 문서

- [기획서](PLAN.md) · [참고 자료](REFERENCES.md) · [변경 기록](CHANGELOG.md)
