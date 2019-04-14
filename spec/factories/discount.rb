FactoryBot.define do
  factory :discount do
    association :item, factory: :item
    sequence(:amount_off) { |n| "#{n}".to_i }
    sequence(:required_min_price) { |n| "#{n}".to_i }
    enable { true }
  end 

  factory :disabled_discount, parent: :discount do
    association :item, factory: :item
    disable { false }
  end
  end
