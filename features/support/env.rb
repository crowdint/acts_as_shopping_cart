require 'bundler/setup'

require 'active_record'
require 'database_cleaner'
require 'money-rails'

$: << './lib'

require 'acts_as_shopping_cart'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

MoneyRails::Hooks.init

require 'simplecov'

SimpleCov.coverage_dir 'coverage.features'
SimpleCov.start
