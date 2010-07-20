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
      @cart.add(@product)
      @cart.items(true).first.should_not be_nil
      @cart.items(true).first.item.should == @product
    end
  end

  describe :total do
    it "has a total" do
      @cart.should respond_to(:total)
    end

    context "there are products on the cart" do
      before(:each) do
        @cart.add(Product.create(:name => "Product 1"), 199.99)
        @cart.add(Product.create(:name => "Product 2"), 299.99)
      end

      it "should return the sum of the item prices" do
        @cart.total.should == 499.98
      end
    end

    context "the cart has no item" do
      it "should return 0" do
        @cart.total == 0
      end
    end
  end
end
