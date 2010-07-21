# acts_as_shopping_cart

A simple shopping cart implementation. Still on Alpha, use it at your own risk.

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
      acts_as_shopping_cart 'CartItem'
    end


For the items:

    class CartItem < ActiveRecord::Base
      acts_as_shopping_cart_item 'Cart'
    end

### Migrations

In order for this to work, the Shopping Cart Item model should have the following fields:

    create_table :cart_items do |t|
        t.integer :shopping_cart_id   # Holds the association with the cart
        t.integer :quantity           # Holds the quantity of the object
        t.integer :item_id            # Holds the object id
        t.string :item_type           # Holds the type of teh object, for polymorphism
        t.float :price                # Holds the price of the item
    end

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

### Total unique items

You can find out how many unique items you have on your cart using the _total_unique_items_ method.

So, if you had something like:

    @cart.add(@product, 99.99, 5)
    
Then,

    @cart.total_unique_items # => 5

## TODO

* Finish this document
* Test it on Rails 2
* Some more useful methods, like @cart.quantity_for(@product), @cart.price_for(@product)