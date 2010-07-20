$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'active_record/acts/shopping_cart'
require 'active_record/acts/shopping_cart_item'
require 'spec'
require 'spec/autorun'
require 'rubygems'

# gem 'rails', '>=3.0.0.beta4'

# require "active_support"
require "active_record"
# require "active_model"
# # require "action_controller"
# require "rails/railtie"


Spec::Runner.configure do |config|
  
end
