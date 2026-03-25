const { Given, When, Then } = require('@cucumber/cucumber');
const assert = require('assert');
const hello = require('../../../bin/hello.js');

let result;
let input;

When('I greet {string}', function (name) {
  result = hello.greet(name);
});

Then('the output is {string}', function (expected) {
  assert.strictEqual(result, expected);
});

Given('a blank string', function () {
  input = '';
});

When('we call parse', function () {
  result = JSON.parse(hello.parse(input));
});

Then('it returns an empty json object', function () {
  assert.deepStrictEqual(result, {});
});
