Given /^a shopping cart exists$/ do
  @cart = ShoppingCart.create
end

Then /^the total for the cart should be "([^"]*)"$/ do |total|
	@cart.reload
  @cart.total.should eq(total.to_f)
end

Then /^the subtotal for the cart should be "([^"]*)"$/ do |subtotal|
	@cart.reload
  @cart.subtotal.should eq(subtotal.to_f)
end

When /^I add product "([^"]*)" to cart with price "([^"]*)"$/ do |product_name, price|
  product = Product.find_by_name(product_name)
  @cart.add(product, price)
end

Then /^the total unique items on the cart should be "([^"]*)"$/ do |total|
	@cart.reload
	@cart.total_unique_items.should eq(total.to_i)
end

When /^I remove (\d+) "([^"]*)" unit(s?) from cart$/ do |quantity, product_name, plural|
	@cart.reload
  product = Product.find_by_name(product_name)
	@cart.remove(product, quantity.to_i)
end

Then /^cart should be empty$/ do
	@cart.reload
	@cart.cart_items.should be_empty
end
