require 'open3'

BIN = File.expand_path('../../../bin/hello', __dir__)

When('the hello world function is called') do
  @output, _, @status = Open3.capture3(BIN)
  @output.chomp!
end

When('I greet {string}') do |name|
  @output, _, @status = Open3.capture3(BIN, name)
  @output.chomp!
end

Then('the output is {string}') do |expected|
  expect(@output).to eq(expected)
end
