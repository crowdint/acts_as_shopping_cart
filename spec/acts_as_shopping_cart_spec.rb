require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class SomeCart < ActiveRecord::Base
  acts_as_shopping_cart 'SomeCartItem'
end

class SomeCartItem < ActiveRecord::Base
  acts_as_shopping_cart_item 'SomeCart'
end

class SomeClass < ActiveRecord::Base

end

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :some_carts do |t|

  end

  create_table :some_classes do |t|

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

  describe :item_for do
    context "the item is in the cart" do
      before(:each) do
        @some_object = SomeClass.create
        @cart.add(@some_object, 1)
      end

      it "returns the item object" do
        @cart.item_for(@some_object).item.should == @some_object
      end
    end

    context "the item is not on the cart" do
      it "returns nil" do
        product = SomeClass.create
        @cart.item_for(product).should be_nil
      end
    end
  end

  describe :add do
    it "adds an item" do
      @some_object = SomeClass.create
      @cart.add(@some_object, 100)
      @cart.cart_items(true).first.should_not be_nil
      @cart.cart_items(true).first.item.should == @some_object
    end

    context "add more of an item already in the cart" do
      it "increases the quantity of the item" do
        @some_object = SomeClass.create
        @cart.add(@some_object, 100)
        @cart.add(@some_object, 100, 2)

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
        @cart.add(SomeClass.create, 199.99, 2)
        @cart.add(SomeClass.create, 299.99)
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
        @some_object = SomeClass.create
        @cart.add(@some_object, 199.99)
        @cart.add(SomeClass.create, 299.99)
      end

      it "removes the item from the cart" do
        @cart.remove(@some_object)
        @cart.cart_items.count.should == 1
        @cart.item_for(@some_object).should be_nil
      end
    end

    context "remove some items" do
      before(:each) do
        @some_object = SomeClass.create
        @cart.add(@some_object, 199.99, 5)
        @cart.add(SomeClass.create, 299.99)
      end

      it "removes 2 items of the specific product" do
        @cart.remove(@some_object, 2)
        @cart.item_for(@some_object).should_not be_nil
        @cart.item_for(@some_object).quantity.should == 3
      end
    end

    context "the object is not on the cart" do
      before(:each) do
        @some_object = SomeClass.create
      end
      it "does nothing" do
        @cart.remove(@some_object)
      end
    end

    describe :total_unique_items do
      context "there are different items in the cart" do
        before(:each) do
          @cart.add(SomeClass.create, 100, 1)
          @cart.add(SomeClass.create, 100, 2)
          @cart.add(SomeClass.create, 100, 3)
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

    describe :subtotal_for do
      context "the item exists in the cart" do
        before(:each) do
          @some_object = SomeClass.create
          @cart.add(@some_object, 300, 5)
          @cart.add(SomeClass.create, 100, 3)
        end

        it "returns the quantity times the price for the specicfied object" do
          @cart.subtotal_for(@some_object).should == (300 * 5)
        end
      end

      context "the item doesn't exist on the cart" do
        it "returns nil" do
          @cart.subtotal_for(SomeClass.create).should be_nil
        end
      end
    end
  end
end
