module ActiveRecord
  module Acts
    module ShoppingCart
      module Item

        #
        # Returns the cart item for the specified object
        #
        def item_for(object)
          shopping_cart_items.where(item: object).first
        end

        #
        # Returns the subtotal of a specified item by multiplying the quantity times
        # the price of the item.
        #
        def subtotal_for(object)
          item = item_for(object)
          item ? item.subtotal : 0
        end

        #
        # Returns the quantity of the specified object
        #
        def quantity_for(object)
          item = item_for(object)
          item ? item.quantity : 0
        end

        #
        # Updates the quantity of the specified object
        #
        def update_quantity_for(object, new_quantity)
          item = item_for(object)
          item.update_quantity(new_quantity) if item
        end

        #
        # Returns the price of the specified object
        #
        def price_for(object)
          item = item_for(object)
          item ? item.price : 0
        end

        #
        # Updates the price of the specified object
        #
        def update_price_for(object, new_price)
          item = item_for(object)
          item.update_price(new_price) if item
        end
      end
    end
  end
end
