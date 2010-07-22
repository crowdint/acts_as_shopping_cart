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
        def acts_as_shopping_cart(item_class_name)
          self.send :include, ActiveRecord::Acts::ShoppingCart::InstanceMethods
          has_many :cart_items, :class_name => item_class_name, :foreign_key => "shopping_cart_id"
        end
      end

      module InstanceMethods
        #
        # Returns the total by summing the price times quantity for all the items in the cart
        #
        def total
          cart_items.sum("price * quantity").to_f
        end

        #
        # Adds a product to the cart
        #
        def add(object, price, quantity = 1)
          cart_item = item_for(object)

          unless cart_item
            cart_items.create(:item => object, :price => price, :quantity => quantity)
          else
            cart_item.quantity = (cart_item.quantity + quantity)
            cart_item.save
          end
        end

        #
        # Remove an item from the cart
        #
        def remove(object, quantity = 1)
          cart_item = item_for(object)
          if cart_item
            if cart_item.quantity <= quantity
              cart_items.delete(cart_item)
            else
              cart_item.quantity = (cart_item.quantity - quantity)
              cart_item.save
            end
          end
        end

        #
        # Returns the cart item for the specified object
        #
        def item_for(object)
          cart_items.where(:item_id => object.id).first
        end

        #
        # Return the number of unique items in the cart
        #
        def total_unique_items
          cart_items.sum(:quantity)
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
      end
    end
  end
end