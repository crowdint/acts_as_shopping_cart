module ActiveRecord
  module Acts
    module ShoppingCart
      module InstanceMethods
        #
        # Returns the cart item for the specified object
        #
        def item_for(object)
          cart_items.where(:item_id => object.id).first
        end

        #
        # Returns the subtotal of a specified item by multiplying the quantity times
        # the price of the item.
        #
        def subtotal_for(object)
          item = item_for(object)
          if item
            item.quantity * item.price
          end
        end

        #
        # Returns the quantity of the specified object
        #
        def quantity_for(object)
          item = item_for(object)
          item ? item.quantity : 0
        end

        #
        # Returns the price of the specified object
        #
        def price_for(object)
          item = item_for(object)
          item ? item.price : 0
        end
      end
    end
  end
end