require 'acts_as_shopping_cart/version'
require 'active_record/acts/shopping_cart'
require 'active_record/acts/shopping_cart_item'
require 'acts_as_shopping_cart/schema'

module ActiveRecord
  module Acts
    module ShoppingCart
      autoload :Collection, 'active_record/acts/shopping_cart/collection'

      module Item
        autoload :InstanceMethods, 'active_record/acts/shopping_cart/item/instance_methods'
      end
    end

    module ShoppingCartItem
      autoload :InstanceMethods, 'active_record/acts/shopping_cart_item/instance_methods'
    end
  end
end

ActiveRecord::Base.send :include, ActiveRecord::Acts::ShoppingCart
ActiveRecord::Base.send :include, ActiveRecord::Acts::ShoppingCartItem
