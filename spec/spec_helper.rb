$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'spec'
require 'spec/autorun'
require 'rubygems'

require 'acts_as_shopping_cart'

Spec::Runner.configure do |config|

end

#
# Required environment for the tests
#
class SomeCart < ActiveRecord::Base
  acts_as_shopping_cart_using :some_cart_item
end

class SomeCartItem < ActiveRecord::Base
  acts_as_shopping_cart_item_for :some_cart
end

class ShoppingCart < ActiveRecord::Base
  acts_as_shopping_cart
end

class ShoppingCartItem < ActiveRecord::Base
  acts_as_shopping_cart_item
end

class SomeClass < ActiveRecord::Base

end

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :some_carts do |t|

  end

  create_table :some_classes do |t|

  end

  create_table :some_cart_items do |t|
    t.integer :shopping_cart_id
    t.integer :quantity
    t.integer :item_id
    t.string :item_type
    t.float :price
  end
end