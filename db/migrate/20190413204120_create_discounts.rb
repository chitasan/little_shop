class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.integer :amount_off, default: 0
      t.integer :required_min_price, default: 0
      t.references :order_items, foreign_key: true

      t.timestamps
    end
  end
end
