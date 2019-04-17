require 'rails_helper'

RSpec.describe 'As a merchant' do
  describe 'can delete a discount' do
    it 'that is percentage based' do
      merchant = create(:merchant, discount_type: 0)
      discount = create(:discount, amount_off: 5, quantity: 2..99, item_total: 0, kind: 0, merchant_id: merchant.id)

      login_as(merchant)

      visit dashboard_discounts_path

      within '.discounts' do 
        expect(page).to have_content(discount.amount_off)
      end

      within "#discount-#{discount.id}" do 
        click_link "Delete"
      end

      expect(current_path).to eq(dashboard_discounts_path)

      within '.discounts' do 
        expect(page).to_not have_content(discount.amount_off)
      end
    end 

    it 'that is dollar based' do 
      merchant = create(:merchant, discount_type: 1)
      discount = create(:discount, amount_off: 20, quantity: 2..4, item_total: 22, kind: 1, merchant_id: merchant.id)
      
      login_as(merchant)

      visit dashboard_discounts_path

      within '.discounts' do 
        expect(page).to have_content(discount.amount_off)
      end

      within "#discount-#{discount.id}" do 
        click_link "Delete"
      end

      expect(current_path).to eq(dashboard_discounts_path)

      within '.discounts' do 
        expect(page).to_not have_content(discount.amount_off)
      end
    end 
  end 
end 