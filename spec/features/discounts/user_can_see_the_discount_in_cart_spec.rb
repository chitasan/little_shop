require 'rails_helper'

RSpec.describe 'As a user' do
  it 'can see precentage-based discounts applied in cart' do
    merchant = create(:merchant, discount_type: 0)
    merchant_2 = create(:merchant, discount_type: 0)

    discount_1 = create(:discount, amount_off: 5, quantity: 1..4, merchant_id: merchant.id, kind: 0)

    item_1 = create(:item, merchant_id: merchant.id, price: 100)
    item_2 = create(:item, merchant_id: merchant_2.id)

    user = create(:user)

    login_as(user)

    visit item_path(item_1)

    click_button "Add to Cart"

    visit cart_path
    
    expect(page).to have_content("subtotal: $95.00")
  end 
end 