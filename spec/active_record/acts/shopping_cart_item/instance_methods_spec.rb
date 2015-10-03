require File.expand_path(File.dirname(__FILE__) + "../../../../spec_helper")

describe ActiveRecord::Acts::ShoppingCartItem::InstanceMethods do
  let(:klass) do
    klass = Class.new
    klass.send :include, ActiveRecord::Acts::ShoppingCartItem::InstanceMethods
    klass
  end

  let(:subject) do
    subject = klass.new
    subject.stub(save: true)
    subject
  end

  describe :subtotal do
    it "returns the quantity * price" do
      subject.stub(quantity: 2, price: 33.99)
      subject.subtotal.should eq(67.98)
    end
  end

  describe :update_quantity do
    it "updates the item quantity" do
      subject.should_receive(:quantity=).with(5)
      subject.should_receive(:save)
      subject.update_quantity(5)
    end
  end

  describe :update_price do
    it "updates the item price" do
      subject.should_receive(:price=).with(55.99)
      subject.should_receive(:save)
      subject.update_price(55.99)
    end
  end
end
