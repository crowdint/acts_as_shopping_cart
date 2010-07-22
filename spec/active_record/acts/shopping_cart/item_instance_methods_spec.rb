require File.expand_path(File.dirname(__FILE__) + '../../../../spec_helper')

describe "ShoppingCart" do
  before(:each) do
    @cart = SomeCart.create
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

    describe :quantity_for do
      context "the item is in the cart" do
        before(:each) do
          @some_object = SomeClass.create
          @cart.add(@some_object, 100, 5)
        end

        it "returns the quantity of the specified object" do
          @cart.quantity_for(@some_object).should == 5
        end
      end

      context "the item is not on the cart" do
        it "returns 0" do
          @cart.quantity_for(SomeClass.create).should == 0
        end
      end
    end

    describe :update_quantity_for do
      context "the item is in the cart" do
        before(:each) do
          @some_object = SomeClass.create
          @cart.add(@some_object, 100, 5)
        end

        it "returns the quantity of the specified object" do
          @cart.update_quantity_for(@some_object, 7)
          @cart.quantity_for(@some_object).should == 7
        end
      end

      context "the item is not on the cart" do
        it "deos nothing" do
          @cart.update_quantity_for(SomeClass.create, 7)
        end
      end
    end

    describe :price_for do
      context "the item is in the cart" do
        before(:each) do
          @some_object = SomeClass.create
          @cart.add(@some_object, 99.99, 5)
        end

        it "returns the price of the specified object" do
          @cart.price_for(@some_object).should == 99.99
        end
      end

      context "the item is not on the cart" do
        it "returns 0" do
          @cart.price_for(SomeClass.create).should == 0
        end
      end
    end

    describe :update_price_for do
      context "the item is in the cart" do
        before(:each) do
          @some_object = SomeClass.create
          @cart.add(@some_object, 100, 5)
        end

        it "returns the quantity of the specified object" do
          @cart.update_price_for(@some_object, 39.99)
          @cart.price_for(@some_object).should == 39.99
        end
      end

      context "the item is not on the cart" do
        it "deos nothing" do
          @cart.update_price_for(SomeClass.create, 39.99)
        end
      end
    end
  end
end
