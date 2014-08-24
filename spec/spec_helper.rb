require 'byebug'
require 'active_support/all'

RSpec.configure do |config|
  # No more monkey business!
  config.disable_monkey_patching!
  config.expose_dsl_globally = false

  # Allow the use of focus: true
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Use doc formatter when running a single spec file
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  # Use env to enable spec profiling
  ENV['PROFILE_SPECS'] ||= '0'
  if ENV['PROFILE_SPECS'].to_i > 1
    config.profile_examples = ENV['PROFILE_SPECS'].to_i
  end

  # Expect and mock with rspec
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
