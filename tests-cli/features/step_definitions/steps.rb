When('the hello world function is called') do
  run_command_and_stop('hello', fail_on_error: true)
  @output = last_command_started.stdout.chomp
end

When('I greet {string}') do |name|
  run_command_and_stop("hello #{name}", fail_on_error: true)
  @output = last_command_started.stdout.chomp
end

Then('the output is {string}') do |expected|
  expect(@output).to eq(expected)
end
