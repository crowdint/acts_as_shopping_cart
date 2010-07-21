require 'active_record'
require 'active_record/acts/shopping_cart'
require 'active_record/acts/shopping_cart_item'

ActiveRecord::Base.send :include, ActiveRecord::Acts::ShoppingCart::InstanceMethods
ActiveRecord::Base.send :extend, ActiveRecord::Acts::ShoppingCart::ClassMethods
ActiveRecord::Base.send :extend, ActiveRecord::Acts::ShoppingCartItem::ClassMethods