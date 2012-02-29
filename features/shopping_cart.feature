Feature: Shopping Cart

  Background:
    Given a product "Apple" exists
    And a shopping cart exists

  Scenario: Cart totals
    When I add product "Apple" to cart with price "99.99"
    Then the subtotal for the cart should be "99.99"
    And the total for the cart should be "108.24"
    And the total unique items on the cart should be "1"

  Scenario: Cart Totals when cart is empty
    Then the subtotal for the cart should be "0"
    And the total for the cart should be "0"
    And the total unique items on the cart should be "0"

  Scenario: Add a product to cart twice
    When I add product "Apple" to cart with price "99.99"
    And I add product "Apple" to cart with price "99.99"
    Then the subtotal for the cart should be "199.98"
    Then the total for the cart should be "216.48"
    And the total unique items on the cart should be "2"

  Scenario: Add a product to cart twice non-cumulatively
    When I add product "Apple" to cart with price "99.99"
    And I add product "Apple" to cart with price "99.99"
    And I non-cumulatively add product "Apple" to cart with price "99.99"
    Then the subtotal for the cart should be "99.99"
    Then the total for the cart should be "108.24"
    And the total unique items on the cart should be "1"

  Scenario: Remove products from cart
    Given I add 3 "Apple" products to cart with price "99.99"
    When I remove 1 "Apple" unit from cart
    Then the total unique items on the cart should be "2"
    When I remove 99 "Apple" units from cart
    Then the total unique items on the cart should be "0"
    And cart should be empty

  Scenario: Totals for a single item
    Given I add 3 "Apple" products to cart with price "99.99"
    Then the subtotal for "Apple" on the cart should be "299.97"
    And the quantity for "Apple" on the cart should be "3"
    And the price for "Apple" on the cart should be "99.99"

  Scenario: Subtotal for a product that is not on cart
    Then the subtotal for "Apple" on the cart should be "0"

  Scenario: Update the quantity of a cart item
    Given I add 99 "Apple" products to cart with price "99.99"
    When I update the "Apple" quantity to "2"
    Then the quantity for "Apple" on the cart should be "2"

  Scenario: Update the price of a cart item
    Given I add 99 "Apple" products to cart with price "99.99"
    When I update the "Apple" price to "10.99"
    Then the price for "Apple" on the cart should be "10.99"

  Scenario: Empty the shopping cart
    Given I add 99 "Apple" products to cart with price "99.99"
    When I empty the cart
    Then cart should be empty
    And the total for the cart should be "0"

  Scenario: Item should hold a relation to cart
    When I add product "Apple" to cart with price "99.99"
    Then shopping cart item "Apple" should belong to cart


