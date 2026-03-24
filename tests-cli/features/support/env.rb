require 'aruba/cucumber'

Before do
  prepend_environment_variable(
    'PATH',
    "#{File.expand_path('../../../bin', __dir__)}#{File::PATH_SEPARATOR}"
  )
end
