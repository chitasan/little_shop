require 'rails_helper'

RSpec.describe 'As a user' do
  xit 'can see precentage-based discounts applied in cart' do
    merchant = create(:merchant, discount_type: 0)
    merchant_2 = create(:merchant, discount_type: 0)

    discount_1 = create(:discount, amount_off: 5, quantity: 1..4, merchant_id: merchant.id, kind: 0)
    discount_2 = create(:discount, amount_off: 10, quantity: 5..10, merchant_id: merchant.id, kind: 0)
    discount_3 = create(:discount, amount_off: 15, quantity: 5..10, merchant_id: merchant_2.id, kind: 0)

    item_1 = create(:item, merchant_id: merchant.id, price: 100)
    item_2 = create(:item, merchant_id: merchant_2.id)

    user = create(:user)

    login_as(user)

    visit item_path(item_1)

    click_button "Add to Cart"

    visit cart_path
    
    expect(page).to have_content("Total: $95.00")
  end 

  xit 'can see dollar-based discounts applied in cart' do
    merchant = create(:merchant, discount_type: 1)
    merchant_2 = create(:merchant, discount_type: 0)

    discount_1 = create(:discount, amount_off: 5, quantity: 1..4, merchant_id: merchant.id, kind: 0)
    discount_2 = create(:discount, amount_off: 10, quantity: 5..10, merchant_id: merchant.id, kind: 0)
    discount_3 = create(:discount, amount_off: 15, quantity: 5..10, merchant_id: merchant_2.id, kind: 0)

    item_1 = create(:item, merchant_id: merchant.id, price: 100)
    item_2 = create(:item, merchant_id: merchant_2.id)

    user = create(:user)

    login_as(user)

    visit item_path(item_1)

    click_button "Add to Cart"

    visit cart_path

    expect(page).to have_content("Total: $95.00")
  end 
end 