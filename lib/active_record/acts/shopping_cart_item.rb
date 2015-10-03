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
        def acts_as_shopping_cart_item_for(*)
          send :include, ActiveRecord::Acts::ShoppingCartItem::InstanceMethods
          belongs_to :owner, polymorphic: true
          belongs_to :item, polymorphic: true
          monetize :price_cents
        end

        #
        # Alias for:
        #
        #   acts_as_shopping_cart_item_for :shopping_cart
        #
        def acts_as_shopping_cart_item
          acts_as_shopping_cart_item_for :shopping_cart
        end
      end
    end
  end
end
