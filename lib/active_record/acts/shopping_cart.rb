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

      # module InstanceMethods
      def total
        return 100
      end
      # end

      def add(object)
        items.create(:item => object)
      end
    end
  end
end