Feature: Shopping Cart

  Background:
    Given a product "Apple" exists
    And a shopping cart exists

  Scenario: Totals
    When I add product "Apple" to cart with price "99.99"
    Then the subtotal for the cart should be "99.99"
    Then the total for the cart should be "108.24"
