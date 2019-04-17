require 'rails_helper'

RSpec.describe 'As a merchant' do
  describe 'can create a new discount' do 
    it 'on a percentage basis' do 
      merchant = create(:merchant)
      login_as(merchant)

      visit dashboard_discounts_path

      click_link "Add Discount"
      click_link "Use Percentage"
      
      expect(page).to have_button("Dollars based off Item Subtotal") 
      fill_in "Discount (in Percentage)",	with: 5  
      fill_in "Min. Quantity",	with: 1
      fill_in "Max. Quantity",	with: 5
      click_button "Create Discount"

      expect(current_path).to eq(dashboard_discounts_path)
    end 

    it "can create dollar based discounts" do 
      merchant = create(:merchant)
      login_as(merchant)

      visit dashboard_discounts_path

      click_link "Add Discount"
      click_link "Use Dollars/Subtotal"
      expect(page).to have_button("Percentage based off Item Quantity")

      fill_in "Discount (in Dollars off)", with: 5
      fill_in "Subtotal", with: 10
      click_button "Create Discount"

      expect(current_path).to eq(dashboard_discounts_path)
    end
  end 
end 



       

    