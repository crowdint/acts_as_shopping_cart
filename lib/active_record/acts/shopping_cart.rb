module ActiveRecord
  module Acts
    module ShoppingCart
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        #
        # Prepares the class to act as a cart.
        #
        # Receives as a parameter the name of the class that will hold the items
        # 
        # Example:
        #
        #   acts_as_shopping_cart 'CartItem'
        #
        #
        def acts_as_shopping_cart(item_class)
          self.send :include, ActiveRecord::Acts::ShoppingCart::InstanceMethods
          has_many :cart_items, :class_name => item_class.to_s.classify, :foreign_key => "shopping_cart_id"
        end
      end
    end
  end
end