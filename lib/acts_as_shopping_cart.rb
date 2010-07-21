require 'active_record'
require 'active_record/acts/shopping_cart'
require 'active_record/acts/shopping_cart_item'

ActiveRecord::Base.send :include, ActiveRecord::Acts::ShoppingCart
ActiveRecord::Base.send :include, ActiveRecord::Acts::ShoppingCartItem