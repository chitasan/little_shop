class ChangeTypeToDiscounts < ActiveRecord::Migration[5.1]
  def change
    rename_column :discounts, :type, :group
  end
end
