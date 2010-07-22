require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ActsAsShoppingCart" do
  before(:each) do
    @cart = SomeCart.create
  end

  it "has many items" do
    @cart.should respond_to(:cart_items)
    something = SomeClass.create

    @cart.should respond_to(:remove)
    # Test to ensure that any other class doesn't have the methods
    something.should_not respond_to(:remove)
  end
end
