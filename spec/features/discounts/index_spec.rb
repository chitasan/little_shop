require 'rails_helper'

RSpec.describe 'Discounts Index Page' do 
  describe 'as a merchant' do
    before :each do
      @merchant = create(:merchant)
      login_as(@merchant)
    end 

    it "can visit the discounts index page through merchant's dashboard" do
      visit dashboard_path

      click_link('Discounts')

      expect(current_path).to eq(dashboard_discounts_path)
    end 

    it "on discounts index page, can see all merchant's active items and button to enable discount status for each item currently not discounted" do 
      items = create_list(:item, 2, user: @merchant)
      inactive_item = create(:inactive_item, user: @merchant)

      visit dashboard_discounts_path

      items.each do |item|
        within "#discounts-#{item.id}" do
          expect(page).to have_link(item.name)
          expect(page).to have_button('Enable Discount')
        end
      end 

      expect(page).to_not have_content(inactive_item.name)
    end 

    xit "on discounts index page, can see all merchant's active items and button to disable discount status for each item currently currently discounted" do 
      items = create_list(:item, 2, user: @merchant)
      
      visit dashboard_discounts_path

      items.each do |item|
        within "#discounts-#{item.id}" do
          expect(page).to have_link(item.name)
          expect(page).to have_button('Disable Discount')
        end
      end 
    end 
  end
end 