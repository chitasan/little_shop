FactoryBot.define do
  factory :discount do
    association :user, factory: :merchant
    amount_off { 5 }
    quantity { "" }
    item_total { 50 }
    kind { 2 }
    merchant_id {nil}
  end 
end 
