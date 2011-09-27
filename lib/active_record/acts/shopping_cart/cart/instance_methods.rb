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
            ("%.2f" % cart_items.inject(0) { |sum, item| sum += (item.price * item.quantity) }).to_f
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
            cart_items.inject(0) { |sum, item| sum += item.quantity }
          end
        end
      end
    end
  end
end
