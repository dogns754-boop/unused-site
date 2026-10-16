# 새 Windows PC 개발 준비 스크립트
# 사용법 (PowerShell 에서, 저장소 폴더 안에서):
#   powershell -ExecutionPolicy Bypass -File scripts\setup-windows.ps1
# 하는 일: 필요한 도구를 winget 으로 설치 (이미 있으면 건너뜀) → 설치 확인

$ErrorActionPreference = 'Continue'

function Test-Command($name) { [bool](Get-Command $name -ErrorAction SilentlyContinue) }

$tools = @(
    @{ Name = 'Git';           Cmd = 'git';    Id = 'Git.Git';                  Why = '저장소 받기·올리기 (Claude Code 도 필요)' },
    @{ Name = '.NET 10 SDK';   Cmd = 'dotnet'; Id = 'Microsoft.DotNet.SDK.10'; Why = 'PC 프로그램(windows 유형) 빌드' },
    @{ Name = 'Node.js LTS';   Cmd = 'node';   Id = 'OpenJS.NodeJS.LTS';        Why = '휴대폰 앱(mobile)·web 유형' },
    @{ Name = 'Python 3';      Cmd = 'python'; Id = 'Python.Python.3.13';       Why = 'python 유형 (선택)' }
)

if (-not (Test-Command 'winget')) {
    Write-Host '[!] winget 이 없습니다. Microsoft Store 에서 "앱 설치 관리자(App Installer)" 를 설치한 뒤 다시 실행하세요.' -ForegroundColor Red
    exit 1
}

foreach ($t in $tools) {
    if (Test-Command $t.Cmd) {
        Write-Host "[✓] $($t.Name) 이미 있음" -ForegroundColor Green
    } else {
        Write-Host "[…] $($t.Name) 설치 중 — $($t.Why)" -ForegroundColor Yellow
        winget install --id $t.Id -e --accept-source-agreements --accept-package-agreements
    }
}

if (-not (Test-Command 'claude')) {
    Write-Host '[…] Claude Code 설치 중' -ForegroundColor Yellow
    Invoke-RestMethod https://claude.ai/install.ps1 | Invoke-Expression
} else {
    Write-Host '[✓] Claude Code 이미 있음' -ForegroundColor Green
}

Write-Host ''
Write-Host '설치가 끝났습니다. 새로 설치한 도구를 인식하도록 PowerShell 창을 닫고 다시 여세요.' -ForegroundColor Cyan
Write-Host '그다음 저장소 폴더에서:  claude   (또는 Claude 데스크톱 앱의 Code 탭에서 이 폴더 열기)' -ForegroundColor Cyan
