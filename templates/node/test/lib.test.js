import { test } from 'node:test';
import assert from 'node:assert/strict';
import { greet } from '../src/lib.js';

test('greet', () => {
  assert.equal(greet('철수'), '안녕하세요, 철수님!');
});
