require 'simplecov'
SimpleCov.start do
  add_group "Tsumamigui", ['lib/tsumamigui']
end

require 'bundler/setup'
require 'webmock/rspec'
require 'pry'

require 'tsumamigui'

WebMock.allow_net_connect!(net_http_connect_on_start: true)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def fixture_path
  File.expand_path('fixtures', __dir__)
end

def fixture(file)
  File.new(fixture_path + '/' + file).read
end
