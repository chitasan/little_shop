class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.integer :amount_off, default: 0
      t.int4range :quantity
      t.integer :min_subtotal_required, default: 0

      t.timestamps
    end
  end
end
