class AddsDefaultToDiscounts < ActiveRecord::Migration[5.1]
  def change
    change_column :discounts, :type, :integer, default: 2
  end
end
