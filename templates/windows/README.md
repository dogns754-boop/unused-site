# __NAME__

__DESC__

## 실행 (Windows)

```powershell
cd projects\__NAME__
dotnet run --project src\__CSNAME__.App
```

설치 없이 써 보려면: GitHub → Actions → 최근 실행 → **windows-apps** 아티팩트에서 `__NAME__.exe` 다운로드
(처음 실행할 때 .NET 데스크톱 런타임 설치 안내가 뜨면 한 번만 설치)

## 구조

| 폴더 | 내용 | 어디서 테스트 |
|---|---|---|
| `src/__CSNAME__.Core` | 화면과 무관한 로직 (파일 이름 규칙, 설정, 계산 등) | 어디서나 (`dotnet test`) |
| `src/__CSNAME__.App` | WPF 화면, Windows API 호출 | Windows 에서 직접 실행 |
| `tests/__CSNAME__.Core.Tests` | Core 테스트 (xUnit) | 어디서나 |

## 테스트

```bash
scripts/check.sh __NAME__   # 저장소 루트에서
```

## 문서

- [기획서](PLAN.md) · [참고 자료](REFERENCES.md) · [변경 기록](CHANGELOG.md)
