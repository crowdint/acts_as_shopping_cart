module ActiveRecord
  module Acts
    module ShoppingCart
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_shopping_cart(item_class_name)
          has_many :cart_items, :class_name => item_class_name
        end
      end

      def total
        cart_items.sum("price * quantity").to_f
      end

      def add(object, price, quantity = 1)
        cart_item = item_for(object)

        unless cart_item
          cart_items.create(:item => object, :price => price, :quantity => quantity)
        else
          cart_item.quantity = (cart_item.quantity + quantity)
          cart_item.save
        end
      end

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

      def item_for(object)
        cart_items.where(:item_id => object.id).first
      end
      
      def total_unique_items
        cart_items.sum(:quantity)
      end
    end
  end
end