import { test } from 'node:test';
import assert from 'node:assert/strict';
import { greet } from '../src/logic.js';

test('greet', () => {
  assert.equal(greet('철수'), '안녕하세요, 철수님!');
});

test('빈 이름이면 기본값', () => {
  assert.equal(greet('  '), '안녕하세요, 세계님!');
});
