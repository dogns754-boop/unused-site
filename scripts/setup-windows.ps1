# 새 Windows PC 개발 준비 스크립트
# 사용법 (PowerShell 에서, 저장소 폴더 안에서):
#   powershell -ExecutionPolicy Bypass -File scripts\setup-windows.ps1
# 하는 일: 필요한 도구를 winget 으로 설치 (이미 있으면 건너뜀) → 공통 MCP 도구(tools/) → Claude Code 플러그인
# 여러 번 실행해도 안전하다 (이미 설치된 것은 건너뜀).

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

# 공통 MCP 도구 (REA 등) — 저장소 폴더 안에서 실행했을 때만
$toolsDir = Join-Path $PSScriptRoot '..\tools'
if ((Test-Path (Join-Path $toolsDir 'package.json')) -and (Test-Command 'npm')) {
    Write-Host '[…] 공통 MCP 도구(tools/) 설치 중' -ForegroundColor Yellow
    npm install --prefix $toolsDir --no-audit --no-fund
} else {
    Write-Host '[!] Node.js 설치 후 PowerShell 을 다시 열고 이 스크립트를 한 번 더 실행하면 MCP 도구가 설치됩니다.' -ForegroundColor Yellow
}

# C# 코드 분석기 (csharp-lsp 플러그인이 사용)
if ((Test-Command 'dotnet') -and -not (Test-Command 'csharp-ls')) {
    Write-Host '[…] C# 코드 분석기(csharp-ls) 설치 중' -ForegroundColor Yellow
    dotnet tool install --global csharp-ls
}

# Claude Code 플러그인 (.claude/settings.json 에 켜져 있지만 PC 마다 한 번 설치해야 함)
if (Test-Command 'claude') {
    Push-Location (Join-Path $PSScriptRoot '..')
    claude plugin marketplace add anthropics/claude-plugins-official
    foreach ($p in 'figma', 'frontend-design', 'playwright', 'csharp-lsp') {
        Write-Host "[…] 플러그인 $p 설치 중" -ForegroundColor Yellow
        claude plugin install "$p@claude-plugins-official" --scope project
    }
    Pop-Location
} else {
    Write-Host '[!] Claude Code 설치 후 PowerShell 을 다시 열고 이 스크립트를 한 번 더 실행하면 플러그인이 설치됩니다.' -ForegroundColor Yellow
}

Write-Host ''
Write-Host '설치가 끝났습니다. 새로 설치한 도구를 인식하도록 PowerShell 창을 닫고 다시 여세요.' -ForegroundColor Cyan
Write-Host '처음이면 이 스크립트를 한 번 더 실행하세요 (새로 깐 도구로 남은 설치를 마무리).' -ForegroundColor Cyan
Write-Host '그다음 저장소 폴더에서:  claude   (또는 Claude 데스크톱 앱의 Code 탭에서 이 폴더 열기)' -ForegroundColor Cyan
Write-Host 'Figma 를 쓰려면 Claude Code 안에서 /mcp → figma → Authenticate 로 한 번 로그인하세요.' -ForegroundColor Cyan
