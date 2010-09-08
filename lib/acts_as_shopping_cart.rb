require 'active_record'

require 'active_record/acts/shopping_cart'
require 'active_record/acts/shopping_cart/cart_instance_methods'
require 'active_record/acts/shopping_cart/item_instance_methods'

require 'active_record/acts/shopping_cart_item'
require 'active_record/acts/shopping_cart_item/cart_item_instance_methods'

ActiveRecord::Base.send :extend, ActiveRecord::Acts::ShoppingCart::ClassMethods
ActiveRecord::Base.send :extend, ActiveRecord::Acts::ShoppingCartItem::ClassMethods