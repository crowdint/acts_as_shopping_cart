require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Cart < ActiveRecord::Base
  include ActiveRecord::Acts::ShoppingCart

  acts_as_shopping_cart 'Product'
end

class CartItem < ActiveRecord::Base
  include ActiveRecord::Acts::ShoppingCartItem
  acts_as_shopping_cart_item
end

class Product < ActiveRecord::Base
  def price
    100
  end
end

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :carts do |t|

  end

  create_table :products do |t|
    t.string :name
  end

  create_table :cart_items do |t|
    t.integer :cart_id
    t.integer :quantity
    t.integer :item_id
    t.string :item_type
    t.float :price
  end
end

describe "ActsAsShoppingCart" do
  before(:each) do
    @cart = Cart.create
  end

  it "has many items" do
    @cart.should respond_to(:items)
  end

  describe :add do
    it "adds an item" do
      @product = Product.create(:name => 'Product 1')
      @cart.add(@product, 100)
      @cart.items(true).first.should_not be_nil
      @cart.items(true).first.item.should == @product
    end

    context "add more of an item already in the cart" do
      it "increases the quantity of the item" do
        @product = Product.create(:name => 'Product 1')
        @cart.add(@product, 100)
        @cart.add(@product, 100, 2)

        @cart.items.first.quantity.should == 3
      end
    end
  end

  describe :total do
    it "has a total" do
      @cart.should respond_to(:total)
    end

    context "the cart has items" do
      before(:each) do
        @cart.add(Product.create(:name => "Product 1"), 199.99, 2)
        @cart.add(Product.create(:name => "Product 2"), 299.99)
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
        @product = @cart.add(Product.create(:name => "Product 1"), 199.99)
        @cart.add(Product.create(:name => "Product 2"), 299.99)
      end

      it "removes the item from the cart" do
        @cart.remove(@product)
        @cart.items.count.should == 1
      end
    end

    context "remove some items" do
      before(:each) do
        @product = @cart.add(Product.create(:name => "Product 1"), 199.99, 5)
        @cart.add(Product.create(:name => "Product 2"), 299.99)
      end

      it "removes 2 items of the specific product" do
        @cart.remove(@product, 2)
        @cart.item_for(@product).quantity.should == 3
      end
    end

    context "the object is not on the cart" do
      before(:each) do
        @product = Product.create(:name => "Product 1")
      end
      it "does nothing" do
        @cart.remove(@product)
      end
    end
  end
end
