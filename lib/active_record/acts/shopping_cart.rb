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
        #   acts_as_shopping_cart :cart_item
        #
        #
        def acts_as_shopping_cart_using(item_class)
          self.send :include, ActiveRecord::Acts::ShoppingCart::InstanceMethods
          has_many :cart_items, :class_name => item_class.to_s.classify, :foreign_key => "shopping_cart_id"
        end

        alias_method :acts_as_shopping_cart, :acts_as_shopping_cart_using
      end
    end
  end
end