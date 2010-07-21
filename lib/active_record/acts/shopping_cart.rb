module ActiveRecord
  module Acts
    module ShoppingCart
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_shopping_cart(item_class_name)
          has_many :items, :class_name => 'CartItem'
        end
      end

      def total
        items.sum("price * quantity").to_f
      end

      def add(object, price, quantity = 1)
        item = item_for(object)

        unless item
          items.create(:item => object, :price => price, :quantity => quantity)
        else
          item.quantity = (item.quantity + quantity)
          item.save
        end
      end

      def remove(object, quantity = 1)
        item = item_for(object)
        if item
          if item.quantity <= quantity
            items.delete(items.where(:item_id => object.id))
          else
            item.quantity = (item.quantity - quantity)
            item.save
          end
        end
      end

      def item_for(object)
        items.where(:item_id => object.id).first
      end
    end
  end
end