require 'rails_helper'

RSpec.describe 'Discounts Index Page' do 
  describe 'as a merchant' do
    before :each do
      @merchant = create(:merchant, discount_type: 0)
      @merchant_2 = create(:merchant, discount_type: 0)

      @discount_1 = create(:discount, amount_off: 5, quantity: 1..5, kind: 0, merchant_id: @merchant.id)
      @discount_2 = create(:discount, amount_off: 10, quantity: 5..10, kind: 0, merchant_id: @merchant.id)
      @discount_3 = create(:discount, amount_off: 15, quantity: 10..15, kind: 0, merchant_id: @merchant_2.id)

      login_as(@merchant)
    end 

    it "can visit the discounts index page through merchant's dashboard" do
      visit dashboard_path

      click_link('Discounts')

      expect(current_path).to eq(dashboard_discounts_path)
    end 

    it "see discounts contents on discounts page" do 
      visit dashboard_discounts_path

      within "#discount-#{@discount_1.id}" do 
        expect(page).to have_content("5")
      end 

      within "#discount-#{@discount_2.id}" do 
        expect(page).to have_content("10")
      end 

      within ".discounts" do 
        expect(page).to_not have_content("15")
      end 

      expect(page).to have_button "Switch"
      expect(page).to have_link "Add Discount"
    end 
  end 
end 