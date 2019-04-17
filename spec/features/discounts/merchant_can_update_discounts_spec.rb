require 'rails_helper'

RSpec.describe 'As a merchant' do
  describe 'can update an existing discount' do
    it 'that is percentage based' do
      merchant = create(:merchant, discount_type: 0)
      discount = create(:discount, amount_off: 10, quantity: 1..2, kind: 0, merchant_id: merchant.id)

      login_as(merchant)

      visit dashboard_discounts_path

      within '.discounts' do
        expect(page).to have_content(discount.amount_off)
      end 

      within "#discount-#{discount.id}" do 
        click_link "Update"
      end

      expect(current_path).to eq(edit_dashboard_discount_path(discount))

      fill_in "Discount (in Percentage)",	with: "25"

      click_button "Update Discount"

      expect(current_path).to  eq(dashboard_discounts_path)

      within "#discount-#{discount.id}" do 
        expect(page).to have_content(25)
      end
    end

    it 'that is dollar based' do
      merchant = create(:merchant)
      discount = create(:discount, amount_off: 10, quantity: 1..2, kind: 1, merchant_id: merchant.id)

      login_as(merchant)

      visit dashboard_discounts_path

      click_link "Add Discount"
      click_link "Use Dollars/Subtotal"
      expect(page).to have_button("Percentage based off Item Quantity")

      fill_in "Discount (in Dollars off)", with: 5
      fill_in "Subtotal", with: 10
      click_button "Create Discount"

      expect(current_path).to eq(dashboard_discounts_path)

      within "#discount-#{discount.id}" do
        expect(page).to have_content(5)
      end 
    end 
  end 
end 