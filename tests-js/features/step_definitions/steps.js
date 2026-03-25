const { When, Then } = require('@cucumber/cucumber');
const assert = require('assert');
const hello = require('../../../bin/hello.js');

let result;

When('the hello world function is called', function () {
  result = hello.helloWorld();
});

When('I greet {string}', function (name) {
  result = hello.greet(name);
});

Then('the output is {string}', function (expected) {
  assert.strictEqual(result, expected);
});
