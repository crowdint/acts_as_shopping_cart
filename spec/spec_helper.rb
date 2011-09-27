$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'bundler/setup'

require 'simplecov'
require 'active_record'

require 'acts_as_shopping_cart'

SimpleCov.start

RSpec.configure do |config|
  config.mock_with :rspec
end
