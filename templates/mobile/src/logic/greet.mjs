// 순수 로직 — React Native 없이 node --test 로 테스트한다.
export function greet(name) {
  const trimmed = name.trim();
  return `안녕하세요, ${trimmed || '세계'}님!`;
}
