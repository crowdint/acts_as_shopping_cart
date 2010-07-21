$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'spec'
require 'spec/autorun'
require 'rubygems'

require 'acts_as_shopping_cart'

Spec::Runner.configure do |config|
  
end
