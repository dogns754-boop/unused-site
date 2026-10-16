#!/usr/bin/env bash
# 새 프로젝트를 템플릿에서 생성한다.
# 사용법: scripts/new-project.sh <이름> <유형> ["한 줄 설명"]   (유형: templates/ 아래 폴더 이름)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
name="${1:-}"
type="${2:-}"
desc="${3:-개인용 프로그램}"

types="$(cd "$ROOT/templates" && ls -d */ | tr -d '/' | grep -v '^_' | tr '\n' ' ')"

if [[ -z "$name" || -z "$type" ]]; then
  echo "사용법: scripts/new-project.sh <이름> <유형> [\"한 줄 설명\"]" >&2
  echo "유형: $types" >&2
  exit 2
fi
if [[ ! "$name" =~ ^[a-z][a-z0-9-]*$ ]]; then
  echo "오류: 이름은 영소문자로 시작하고 영소문자·숫자·하이픈만 쓸 수 있습니다 (예: todo-cli)." >&2
  exit 2
fi
if [[ ! -d "$ROOT/templates/$type" || "$type" == _* ]]; then
  echo "오류: 알 수 없는 유형 '$type'. 사용 가능: $types" >&2
  exit 2
fi

if [[ "$desc" =~ [\"\\\<\>\{\}\`] ]]; then
  echo "오류: 설명에는 \" \\ < > { } \` 문자를 쓸 수 없습니다 (코드 파일에 그대로 들어가기 때문)." >&2
  exit 2
fi

dest="$ROOT/projects/$name"
if [[ -e "$dest" ]]; then
  echo "오류: projects/$name 이(가) 이미 있습니다." >&2
  exit 1
fi

pkg="${name//-/_}"                                         # simple-capture → simple_capture (Python)
csname="$(printf '%s' "$name" | sed -E 's/(^|-)([a-z])/\U\2/g')"  # simple-capture → SimpleCapture (C#)
today="$(date +%Y-%m-%d)"

mkdir -p "$dest"
cp -R "$ROOT/templates/_common/." "$dest/"
cp -R "$ROOT/templates/$type/." "$dest/"

# 자리표시자가 들어간 디렉터리/파일 이름 바꾸기 (깊은 것부터)
find "$dest" -depth \( -name '*__PKG__*' -o -name '*__CSNAME__*' \) | while read -r p; do
  mv "$p" "$(dirname "$p")/$(basename "$p" | sed -e "s/__PKG__/$pkg/g" -e "s/__CSNAME__/$csname/g")"
done

# 자리표시자 치환 (sed 특수문자 이스케이프)
esc() { printf '%s' "$1" | sed -e 's/[\/&|\\]/\\&/g'; }
grep -rlIE '__(NAME|PKG|CSNAME|DESC|DATE|TYPE)__' "$dest" | while read -r f; do
  d="$desc"
  case "$f" in *.csproj|*.xaml|*.props) d="${d//&/&amp;}" ;; esac   # XML 파일은 & 이스케이프
  sed -i.bak \
    -e "s|__NAME__|$(esc "$name")|g" \
    -e "s|__PKG__|$(esc "$pkg")|g" \
    -e "s|__CSNAME__|$csname|g" \
    -e "s|__DESC__|$(esc "$d")|g" \
    -e "s|__DATE__|$today|g" \
    -e "s|__TYPE__|$type|g" \
    "$f"
  rm -f "$f.bak"
done

# 실행 파일 권한
find "$dest" -name 'cli.js' -exec chmod +x {} +

# 목록에 추가 (표 셀 안의 | 는 이스케이프)
printf '| [%s](projects/%s/) | %s | %s | 🌱 기획 | %s |\n' \
  "$name" "$name" "$type" "${desc//|/\\|}" "$today" >> "$ROOT/PROJECTS.md"

echo "✅ projects/$name 생성 완료 (유형: $type)"
echo
echo "다음 단계:"
echo "  1) /spec $name       — 기획서(PLAN.md) 채우기"
echo "  2) /research $name   — 참고할 오픈소스 찾기 (선택)"
echo "  3) /feature $name    — 첫 기능 구현"
