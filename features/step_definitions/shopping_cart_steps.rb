Given /^a shopping cart exists$/ do
  @cart = ShoppingCart.create
end

Then /^the total for the cart should be "([^"]*)"$/ do |total|
  @cart.reload
  @cart.total.should eq(Money.new(total.to_f * 100))
end

Then /^the subtotal for the cart should be "([^"]*)"$/ do |subtotal|
  @cart.reload
  @cart.subtotal.should eq(Money.new(subtotal.to_f * 100))
end

When /^I add product "([^"]*)" to cart with price "([^"]*)"$/ do |product_name, price|
  product = Product.find_by_name(product_name)
  @cart.add(product, price)
end

When /^I non-cumulatively add product "([^"]*)" to cart with price "([^"]*)"$/ do |product_name, price|
  product = Product.find_by_name(product_name)
  @cart.add(product, price, 1, false)
end

Then /^the total unique items on the cart should be "([^"]*)"$/ do |total|
  @cart.reload
  @cart.total_unique_items.should eq(total.to_i)
end

When /^I remove (\d+) "([^"]*)" unit(s?) from cart$/ do |quantity, product_name, _|
  @cart.reload
  product = Product.find_by_name(product_name)
  @cart.remove(product, quantity.to_i)
end

When /^I empty the cart$/ do
  @cart.clear
end

Then /^cart should be empty$/ do
  @cart.reload
  @cart.should be_empty
end

Given /^I add (\d+) "([^"]*)" products to cart with price "([^"]*)"$/ do |quantity, product_name, price|
  product = Product.find_by_name(product_name)
  @cart.add(product, price.to_f, quantity.to_i)
end

Then /^the subtotal for "([^"]*)" on the cart should be "([^"]*)"$/ do |product_name, subtotal|
  @cart.reload
  product = Product.find_by_name(product_name)
  @cart.subtotal_for(product).should eq(subtotal.to_f)
end

Then /^the quantity for "([^"]*)" on the cart should be "([^"]*)"$/ do |product_name, quantity|
  @cart.reload
  product = Product.find_by_name(product_name)
  @cart.quantity_for(product).should eq(quantity.to_f)
end

Then /^the price for "([^"]*)" on the cart should be "([^"]*)"$/ do |product_name, price|
  @cart.reload
  product = Product.find_by_name(product_name)
  @cart.price_for(product).should eq(price.to_f)
end

When /^I update the "([^"]*)" quantity to "([^"]*)"$/ do |product_name, quantity|
  @cart.reload
  product = Product.find_by_name(product_name)
  @cart.update_quantity_for(product, quantity.to_i)
end

When /^I update the "([^"]*)" price to "([^"]*)"$/ do |product_name, price|
  @cart.reload
  product = Product.find_by_name(product_name)
  @cart.update_price_for(product, price.to_f)
end

Then /^shopping cart item "([^"]*)" should belong to cart$/ do |_|
  @cart.reload
  shopping_cart_item = ShoppingCartItem.last
  shopping_cart_item.owner.should == @cart
end
