ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
# ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define(version: 1) do
  create_table :shopping_carts
  create_table :shopping_cart_items do |t|
    t.shopping_cart_item_fields
  end

  create_table :products do |t|
    t.string :name
  end
end

class Product < ActiveRecord::Base

end

class ShoppingCart < ActiveRecord::Base
  acts_as_shopping_cart
end

class ShoppingCartItem < ActiveRecord::Base
  acts_as_shopping_cart_item
end
