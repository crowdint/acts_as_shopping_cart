Given /^a shopping cart exists$/ do
  @cart = ShoppingCart.create
end

Then /^the total for the cart should be "([^"]*)"$/ do |total|
  @cart.total.should eq(total.to_f)
end

Then /^the subtotal for the cart should be "([^"]*)"$/ do |subtotal|
  @cart.subtotal.should eq(subtotal.to_f)
end

When /^I add product "([^"]*)" to cart with price "([^"]*)"$/ do |product_name, price|
  product = Product.find_by_name(product_name)
  @cart.add(product, price)
end
