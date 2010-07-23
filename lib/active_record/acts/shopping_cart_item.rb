module ActiveRecord
  module Acts
    module ShoppingCartItem
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        #
        # Prepares the class to act as a cart item.
        #
        # Receives as a parameter the name of the class that acts as a cart
        # 
        # Example:
        #
        #   acts_as_shopping_cart_item :cart
        #
        #
        def acts_as_shopping_cart_item_for(cart_class)
          belongs_to :shopping_cart, :class_name => cart_class.to_s.classify
          belongs_to :item, :polymorphic => true
        end

        alias_method :acts_as_shopping_cart_item, :acts_as_shopping_cart_item_for
      end
    end
  end
end