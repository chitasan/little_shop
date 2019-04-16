class Discount < ApplicationRecord
  belongs_to :user, foreign_key: 'merchant_id'

  validates :amount_off, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  validates :min_subtotal_required, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  } 

  validates_presence_of :quantity
end
