class ChangeMinSubtotalReqToDiscounts < ActiveRecord::Migration[5.1]
  def change
    rename_column :discounts, :min_subtotal_required, :item_total
  end
end
