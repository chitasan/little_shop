class Discount < ApplicationRecord
  belongs_to :user, foreign_key: 'merchant_id'
  belongs_to :item

  validates :amount_off, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  validates :required_min_price, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
end 