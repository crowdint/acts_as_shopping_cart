Feature: Shopping Cart

  Background:
    Given a product "Apple" exists
    And a shopping cart exists

  Scenario: Add product to cart, add it again, then remove it
    When I add product "Apple" to cart with price "99.99"
    Then the subtotal for the cart should be "99.99"
    And the total for the cart should be "108.24"
    And the total unique items on the cart should be "1"
    When I add product "Apple" to cart with price "99.99"
    Then the subtotal for the cart should be "199.98"
    Then the total for the cart should be "216.48"
    And the total unique items on the cart should be "2"
    When I remove 1 "Apple" unit from cart
    Then the total unique items on the cart should be "1"
    When I remove 99 "Apple" units from cart
    Then the total unique items on the cart should be "0"
    And cart should be empty
