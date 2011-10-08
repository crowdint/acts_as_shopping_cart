module ActiveRecord
  module Acts
    module ShoppingCart
      module Cart
        module InstanceMethods
          #
          # Adds a product to the cart
          #
          def add(object, price, quantity = 1)
            cart_item = item_for(object)

            unless cart_item
              shopping_cart_items.create(:item => object, :price => price, :quantity => quantity)
            else
              cart_item.quantity = (cart_item.quantity + quantity)
              cart_item.save
            end
          end

          #
          # Deletes all shopping_cart_items in the shopping_cart
          #
          def clear
            shopping_cart_items.clear
          end

          #
          # Returns true when the cart is empty
          #
          def empty?
            shopping_cart_items.empty?
          end

          #
          # Remove an item from the cart
          #
          def remove(object, quantity = 1)
            if cart_item = item_for(object)
              if cart_item.quantity <= quantity
                cart_item.delete
              else
                cart_item.quantity = (cart_item.quantity - quantity)
                cart_item.save
              end
            end
          end

          #
          # Returns the subtotal by summing the price times quantity for all the items in the cart
          #
          def subtotal
            ("%.2f" % shopping_cart_items.inject(0) { |sum, item| sum += (item.price * item.quantity) }).to_f
          end

          def shipping_cost
            0
          end

          def taxes
            subtotal * self.tax_pct * 0.01
          end

          def tax_pct
            8.25
          end

          #
          # Returns the total by summing the subtotal, taxes and shipping_cost
          #
          def total
            ("%.2f" % (self.subtotal + self.taxes + self.shipping_cost)).to_f
          end

          #
          # Return the number of unique items in the cart
          #
          def total_unique_items
            shopping_cart_items.inject(0) { |sum, item| sum += item.quantity }
          end

          def cart_items
            warn "ShoppingCart#cart_items WILL BE DEPRECATED IN LATER VERSIONS OF acts_as_shopping_cart, please use ShoppingCart#shopping_cart_items instead"
            self.shopping_cart_items
          end
        end
      end
    end
  end
end
