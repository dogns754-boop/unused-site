# simple-pdf

보다 간단한 PDF — 가볍고 편한 PDF 보기·편집

## 실행 (Windows)

```powershell
cd projects\simple-pdf
dotnet run --project src\SimplePdf.App
```

설치 없이 써 보려면: GitHub → Actions → 최근 실행 → **windows-apps** 아티팩트에서 `simple-pdf.exe` 다운로드
(처음 실행할 때 .NET 데스크톱 런타임 설치 안내가 뜨면 한 번만 설치)

## 구조

| 폴더 | 내용 | 어디서 테스트 |
|---|---|---|
| `src/SimplePdf.Core` | 화면과 무관한 로직 (파일 이름 규칙, 설정, 계산 등) | 어디서나 (`dotnet test`) |
| `src/SimplePdf.App` | WPF 화면, Windows API 호출 | Windows 에서 직접 실행 |
| `tests/SimplePdf.Core.Tests` | Core 테스트 (xUnit) | 어디서나 |

## 테스트

```bash
scripts/check.sh simple-pdf   # 저장소 루트에서
```

## 문서

- [기획서](PLAN.md) · [참고 자료](REFERENCES.md) · [변경 기록](CHANGELOG.md)
