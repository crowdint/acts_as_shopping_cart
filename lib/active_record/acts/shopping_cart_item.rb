module ActiveRecord
  module Acts
    module ShoppingCartItem
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_shopping_cart_item
          belongs_to :cart
          belongs_to :item, :polymorphic => true
        end
      end
    end
  end
end