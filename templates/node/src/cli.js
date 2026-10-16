#!/usr/bin/env node
import { greet } from './lib.js';

const [name = '세계'] = process.argv.slice(2);
console.log(greet(name));
