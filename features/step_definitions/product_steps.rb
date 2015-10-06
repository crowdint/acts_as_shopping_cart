Given /^a product "([^"]*)" exists$/ do |name|
  Product.create(name: name)
end
