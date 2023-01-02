# frozen_string_literal: true

require 'rubocop-grape'
require 'rubocop/rspec/support'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.include RuboCop::RSpec::ExpectOffense

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.raise_on_warning = true
  config.raise_errors_for_deprecations!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
