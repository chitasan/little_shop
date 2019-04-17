class ChangeGroupNameToDiscounts < ActiveRecord::Migration[5.1]
  def change
     rename_column :discounts, :group, :kind
  end
end
