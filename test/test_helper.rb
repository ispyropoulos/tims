ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'webmock/minitest'

WebMock.enable!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end

if ENV['RUBYMINE']
  require 'minitest/reporters'
  reporters = [Minitest::Reporters::RubyMineReporter.new]
  MiniTest::Reporters.use!(reporters)
end
