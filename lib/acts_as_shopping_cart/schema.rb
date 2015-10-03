require "active_record/connection_adapters/abstract/schema_definitions"

module ActsAsShoppingCart
  module Schema
    def shopping_cart_item_fields
      integer :owner_id       # Holds the owner id, for polymorphism
      string  :owner_type     # Holds the type of the owner, for polymorphism
      integer :quantity       # Holds the quantity of the object
      integer :item_id        # Holds the object id
      string  :item_type      # Holds the type of the object, for polymorphism
      integer :price_cents, default: 0, null: false  # Holds the price of the item
      string  :price_currency, default: "USD", null: false # Holds the currency for the price
    end
  end
end

ActiveRecord::ConnectionAdapters::Table.send :include, ActsAsShoppingCart::Schema
ActiveRecord::ConnectionAdapters::TableDefinition.send :include, ActsAsShoppingCart::Schema
