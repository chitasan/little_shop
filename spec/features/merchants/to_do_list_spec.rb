require 'rails_helper'

RSpec.describe 'As a merchant' do
  describe 'can see dashboard on to-do list' do
    it 'items have a default image' do
      item_1 = create(:item, image: "http://s3.amazonaws.com/37assets/svn/765-default-avatar.png")
      item_2 = Item.create(name: 'av', price: 1.0, description: "thing", inventory: 1)

      expect(item_2.image).to eq("https://picsum.photos%") 
    end 

    it 'sees list of items to update image for' do
      merchant = create(:merchant)

      item_1 = create(:item, image: "http://s3.amazonaws.com/37assets/svn/765-default-avatar.png", merchant_id: merchant.id)
      item_2 = Item.create(name: 'av', price: 1.0, description: "thing", inventory: 1, merchant_id: merchant.id)

      login_as(merchant)

      visit dashboard_path

      within "#to-do" do 
        expect(page).to have_link(item_2.name) 
        expect(page).to_not have_link(item_1.name)
        click_link item_2.name
      end 

      expect(current_path).to eq(edit_dashboard_item_path(item_2))
    end 

    it 'sees stats for unfulfilled items and revenue impact' do
      merchant = create(:merchant)
      order = create(:order)
      item_1 = create(:item, merchant_id: merchant.id)
      item_2 = create(:item, merchant_id: merchant.id)
      item_3 = create(:item, merchant_id: merchant.id)
      oi_1 = create(:order_item, item: item_1, order: order)
      oi_2 = create(:order_item, item: item_2, order: order)
      oi_3 = create(:fulfilled_order_item, item: item_3, order: order)

      login_as(merchant)

      visit dashboard_path

      within '#to-do' do
        expect(page).to have_content(merchant.unfulfilled_orders_count)
        expect(merchant.unfulfilled_orders_count).to eq(2)
        expect(page).to have_content(merchant.unfulfilled_orders_revenue)
      end 
    end

    it 'sees warning when sum of an item in orders exceed item inventory' do
      merchant = create(:merchant)

      item_1 = create(:item, user: merchant, inventory: 1)
      item_2 = create(:item, user: merchant, inventory: 5)

      order_1 = create(:order)
      order_2 = create(:order)

      create(:order_item, order_id: order_1.id, item_id: item_1.id, quantity: 1)
      create(:order_item, order_id: order_2.id, item_id: item_1.id, quantity: 3)

      login_as(merchant)

      within "#to-do" do
        expect(page).to have_content("Notice: Your pending orders for #{item_1.name} exceed current inventory.")
      end 
    end 

    it 'sees warning a specific order has items that exceed item inventory' do
      merchant = create(:merchant)

      item_1 = create(:item, user: merchant, inventory: 1)
      item_2 = create(:item, user: merchant, inventory: 5)

      order_1 = create(:order)
      order_2 = create(:order)

      create(:order_item, order_id: order_1.id, item_id: item_1.id, quantity: 2)
      create(:order_item, order_id: order_2.id, item_id: item_1.id, quantity: 3)

      login_as(merchant)

      within "#order-#{order_1.id}" do
        expect(page).to have_content("Notice: Please restock to fulfill your pending order.")
      end 

      within "#order-#{order_2.id}" do
        expect(page).to have_content("Notice: Please restock to fulfill your pending order.")
      end 
    end 
  end 
end 