require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class SomeCart < ActiveRecord::Base
  acts_as_shopping_cart 'SomeCartItem'
end

class SomeCartItem < ActiveRecord::Base
  acts_as_shopping_cart_item 'SomeCart'
end

class Product < ActiveRecord::Base

end

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :some_carts do |t|

  end

  create_table :products do |t|

  end

  create_table :some_cart_items do |t|
    t.integer :shopping_cart_id
    t.integer :quantity
    t.integer :item_id
    t.string :item_type
    t.float :price
  end
end

describe "ActsAsShoppingCart" do
  before(:each) do
    @cart = SomeCart.create
  end

  it "has many items" do
    @cart.should respond_to(:cart_items)
  end

  describe :add do
    it "adds an item" do
      @product = Product.create
      @cart.add(@product, 100)
      @cart.cart_items(true).first.should_not be_nil
      @cart.cart_items(true).first.item.should == @product
    end

    context "add more of an item already in the cart" do
      it "increases the quantity of the item" do
        @product = Product.create
        @cart.add(@product, 100)
        @cart.add(@product, 100, 2)

        @cart.cart_items.first.quantity.should == 3
      end
    end
  end

  describe :total do
    it "has a total" do
      @cart.should respond_to(:total)
    end

    context "the cart has items" do
      before(:each) do
        @cart.add(Product.create, 199.99, 2)
        @cart.add(Product.create, 299.99)
      end

      it "should return the sum of the item prices" do
        @cart.total.should == 699.97
      end
    end

    context "the cart has no item" do
      it "should return 0" do
        @cart.total == 0
      end
    end
  end

  describe :remove do
    context "the cart has items" do
      before(:each) do
        @product = @cart.add(Product.create, 199.99)
        @cart.add(Product.create, 299.99)
      end

      it "removes the item from the cart" do
        @cart.remove(@product)
        @cart.cart_items.count.should == 1
        @cart.item_for(@product).should be_nil
      end
    end

    context "remove some items" do
      before(:each) do
        @product = @cart.add(Product.create, 199.99, 5)
        @cart.add(Product.create, 299.99)
      end

      it "removes 2 items of the specific product" do
        @cart.remove(@product, 2)
        @cart.item_for(@product).quantity.should == 3
      end
    end

    context "the object is not on the cart" do
      before(:each) do
        @product = Product.create
      end
      it "does nothing" do
        @cart.remove(@product)
      end
    end
    
    describe :total_unique_items do
      context "there are different items in the cart" do
        before(:each) do
          @cart.add(Product.create, 100, 1)
          @cart.add(Product.create, 100, 2)
          @cart.add(Product.create, 100, 3)
        end
        
        it "returns the sum of all the item quantities" do
          @cart.total_unique_items.should == 6
        end
      end
      
      context "the cart has no items" do
        it "returns 0" do
          @cart.total_unique_items == 0
        end
      end
    end
  end
end
