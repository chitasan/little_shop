require 'rails_helper'

RSpec.describe 'As a merchant' do
  describe 'can only change discount type after deleting all bulk discounts first' do
    xit 'from percentage to dollar based' do
      merchant = create(:merchant, discount_type: 0)
      discount = create(:discount, amount_off: 5, quantity: 2..99, item_total: 25, kind: 0, merchant_id: merchant.id)

      login_as(merchant)

      visit dashboard_discounts_path
      
      click_button "Switch" 

      expect(page).to have_content("Please delete existing bulk discounts first")

      within "#discount-#{discount.id}" do 
        click_link "Delete"
      end

      click_button "Switch"

      expect(page).to have_content("Your discounts are dollar-based off of an item's subtotal")
    end 

    xit 'from dollar to percentage based' do
      merchant = create(:merchant, discount_type: 0)
      discount = create(:discount, amount_off: 5, quantity: 2..99, item_total: 25, kind: 1, merchant_id: merchant.id)

      login_as(merchant)

      visit dashboard_discounts_path
      
      click_button "Switch" 

      expect(page).to have_content("Please delete existing bulk discounts first")

      within "#discount-#{discount.id}" do 
        click_link "Delete"
      end

      click_button "Switch"

      expect(page).to have_content("Your discounts are based off percentages off of an item's quantities purchased")
    end 
  end 
end 