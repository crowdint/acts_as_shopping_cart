require 'active_record'
require 'database_cleaner'

$: << './lib'

require 'acts_as_shopping_cart'

require 'simplecov'

SimpleCov.coverage_dir 'coverage.features'
SimpleCov.start
