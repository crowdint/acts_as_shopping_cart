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
        items.sum(:price)
      end

      def add(object, price = 0)
        items.create(:item => object, :price => price)
      end
      
      def remove(object)
        items.delete(items.where(:item_id => object.id))
      end
    end
  end
end