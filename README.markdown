# acts_as_shopping_cart

A simple shopping cart implementation.

## Install

### Rails 3

Include it in your Gemfile

    gem 'acts_as_shopping_cart', :git => "git@github.com:crowdint/acts_as_shopping_cart.git"

And run bundler

    bundle install

## Usage

You need two models, one to hold the Shopping Carts and another to hold the Items

You can use any name for the models, you just have to let each model know about each other.

### Examples

For the Shopping Cart:

    class Cart < ActiveRecord::Base
      acts_as_shopping_cart_using :cart_item
    end


For the items:

    class CartItem < ActiveRecord::Base
      acts_as_shopping_cart_item_for :cart
    end

or, if you want to use convention over configuration, make sure your models are called *ShoppingCart* and *ShoppingCartItems*,
then just use the shortcuts:

    class ShoppingCart < ActiveRecord::Base
      acts_as_shopping_cart
    end

    class ShoppingCartItem < ActiveRecord::Base
      acts_as_shopping_cart_item
    end

### Migrations

In order for this to work, the Shopping Cart Item model should have the following fields:

    create_table :cart_items do |t|
      t.shopping_cart_item_fields # Creates the cart items fields
    end

### Shopping Cart Items

Your ShoppingCart class will have a _shopping_cart_items_ association
that returns all the ShoppingCartItem objects in your cart.

### Add Items

To add an item to the cart you use the add method. You have to send the object and the price of the object as parameters.

So, if you had a Product class, you would do something like this:

    @cart = Cart.create
    @product = Product.find(1)

    @cart.add(@product, 99.99)

In the case where your product has a price field you could do something like:

    @cart.add(@product, @product.price)

I tried to make it independent to the models in case you calculate discounts, sale prices or anything customized.

You can include a quantity parameter too.

    @cart.add(@product, 99.99, 5)

In that case, you would add 5 of the same products to the shopping cart. If you don't specify the quantity 1 will be assumed.

### Remove Items

To remove an item from the cart you can use the remove method. You just have to send the object and the quantity you want to remove.

    @cart.remove(@product, 1)

### Total

You can find out about the total using the _total_ method:

    @cart.total # => 99.99

### Taxes

Taxes by default are calculated by multiplying subtotal times 8.25

If you want to change the way taxes are calculated, override the taxes
method on your class that acts_as_shopping_cart.

Example:

    class ShoppingCart < ActiveRecord::Base
      acts_as_shopping_cart

      def taxes
        (subtotal - 10) * 8.3
      end
    end

If you just want to update the percentage, just override the tax_pct
method.

    class ShoppingCart < ActiveRecord::Base
      acts_as_shopping_cart

      def tax_pct
        3.5
      end
    end

### Shipping Cost

Shipping cost will be added to the total. By default its calculated as
0, but you can just override the shipping_cost method on your cart
class depending on your needs.

    class ShoppingCart < ActiveRecord::Base
      acts_as_shopping_cart

      def shipping_cost
        5 # defines a flat $5 rate
      end
    end

### Total unique items

You can find out how many unique items you have on your cart using the _total_unique_items_ method.

So, if you had something like:

    @cart.add(@product, 99.99, 5)

Then,

    @cart.total_unique_items # => 5

## Development

Install the dependencies

    bundle install

### Test

Run rspec

    rspec spec

Run cucumber features

    cucumber

Both:

    rake

# About the Author

[Crowd Interactive](http://www.crowdint.com) is an American web design and development company that happens to work in Colima, Mexico.
We specialize in building and growing online retail stores. We don’t work with everyone – just companies we believe in. Call us today to see if there’s a fit.
Find more info [here](http://www.crowdint.com)!
