class AddTypeToDiscounts < ActiveRecord::Migration[5.1]
  def change
    add_column :discounts, :type, :integer
  end
end
