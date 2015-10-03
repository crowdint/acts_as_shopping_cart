require File.expand_path(File.dirname(__FILE__) + "../../../../spec_helper")

describe ActiveRecord::Acts::ShoppingCart::Item do
  let(:klass) do
    klass = Class.new
    klass.send :include, ActiveRecord::Acts::ShoppingCart::Item
    klass
  end

  let(:shopping_cart_items) { stub }

  let(:subject) do
    subject = klass.new
    subject.stub(:shopping_cart_items).and_return(shopping_cart_items)
    subject
  end

  let(:object) { stub(id: 1) }
  let(:item)   { stub(subtotal: 47.98, price: 23.99, quantity: 2, save: true)}

  describe :item_for do
    context "no cart item exists for the object" do
      before do
        shopping_cart_items.should_receive(:where).with(item: object).and_return([])
      end

      it "returns the shopping cart item object for the requested object" do
        subject.item_for(object).should be_nil
      end
    end

    context "a cart item exists for the object" do
      before do
        shopping_cart_items.should_receive(:where).with(item: object).and_return([item])
      end

      it "returns that item" do
        subject.item_for(object).should be(item)
      end
    end
  end

  describe :subtotal_for do
    context "no cart item exists for the object" do
      before do
        subject.should_receive(:item_for).with(object)
      end

      it "returns 0" do
        subject.subtotal_for(object).should eq(0.0)
      end
    end

    context "the cart item exists for the object" do
      before do
        subject.should_receive(:item_for).with(object).and_return(item)
      end

      it "returns the subtotal for the item" do
        subject.subtotal_for(object).should eq(47.98)
      end
    end
  end

  describe :quantity_for do
    context "no cart item exists for the object" do
      before do
        subject.should_receive(:item_for).with(object)
      end

      it "returns 0" do
        subject.quantity_for(object).should eq(0)
      end
    end

    context "the cart item exists for the object" do
      before do
        subject.should_receive(:item_for).with(object).and_return(item)
      end

      it "returns the quantity for the object" do
        subject.quantity_for(object).should eq(2)
      end
    end
  end

  describe :update_quantity_for do
    context "the cart item exists for the object" do
      before do
        subject.should_receive(:item_for).with(object).and_return(item)
      end

      it "updates the item quantity to the specified quantity" do
        item.should_receive(:update_quantity).with(3)
        subject.update_quantity_for(object, 3)
      end
    end
  end

  describe :price_for do
    context "no cart item exists for the object" do
      before do
        subject.should_receive(:item_for).with(object)
      end

      it "returns 0" do
        subject.price_for(object).should eq(0.0)
      end
    end

    context "the cart item exists for the object" do
      before do
        subject.should_receive(:item_for).with(object).and_return(item)
      end

      it "returns the price of the item" do
        subject.price_for(object).should eq(23.99)
      end
    end
  end

  describe :update_price_for do
    context "the cart item exists for the object" do
      before do
        subject.should_receive(:item_for).with(object).and_return(item)
      end

      it "updates the price on the item" do
        item.should_receive(:update_price).with(99.99)
        subject.update_price_for(object, 99.99)
      end
    end
  end
end
