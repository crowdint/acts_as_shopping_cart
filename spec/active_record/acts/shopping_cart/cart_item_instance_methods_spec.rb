require File.expand_path(File.dirname(__FILE__) + '../../../../spec_helper')

describe "ShoppingCart" do
  before(:each) do
    @cart = SomeCart.create
    @cart.add(SomeClass.create, 100, 3)
    @cart.add(SomeClass.create, 200, 6)
    @cart.add(SomeClass.create, 300, 9)
  end

  describe :subtotal do
    it "returns the quantity times the price for the specicfied object" do
      @cart.cart_items[0].subtotal.should == (100 * 3)
      @cart.cart_items[1].subtotal.should == (200 * 6)
      @cart.cart_items[2].subtotal.should == (300 * 9)
    end
  end

  describe :update_quantity do
    it "returns the quantity of the specified object" do
      @cart.update_quantity_for(@some_object, 7)
      @cart.quantity_for(@some_object).should == 7
    end
  end  
end