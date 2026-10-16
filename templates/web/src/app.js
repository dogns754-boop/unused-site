// DOM 연결만 담당한다. 로직은 logic.js 에.
import { greet } from './logic.js';

const form = document.querySelector('#greet-form');
const input = document.querySelector('#name');
const output = document.querySelector('#output');

form.addEventListener('submit', (event) => {
  event.preventDefault();
  output.textContent = greet(input.value);
});
