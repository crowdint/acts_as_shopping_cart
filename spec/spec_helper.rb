require "rubygems"
require "bundler/setup"

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "simplecov"
require "rails"
require "active_record"
require "money-rails"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

MoneyRails::Hooks.init
require "acts_as_shopping_cart"

SimpleCov.start

RSpec.configure do |config|
  config.mock_with :rspec
end
