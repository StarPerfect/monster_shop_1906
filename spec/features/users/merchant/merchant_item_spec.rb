# As a merchant admin
# When I visit my items page
# I see a link or button to deactivate the item next to each item that is active
# And I click on the "deactivate" button or link for an item
# I am returned to my items page
# I see a flash message indicating this item is no longer for sale
# I see the item is now inactive
require 'rails_helper'

RSpec.describe 'Merchant Admin can CRUD items' do
  before(:each) do
    @bike_city = Merchant.create(name: "Meg's Bike City", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @store_admin = User.create(name: "Billy Joel", address: "123 Billy Street", city: "Denver", state: "CO", zip: "80011", email:"billobill@gmail.com", password: "yours", role: 1,  merchant_id: @bike_city.id )
    @user = User.create(name: "Scott Payton", address: "123 Scott Street", city: "Stapleton", state: "CO", zip: "80011", email:"bigfun@gmail.com", password: "mine", role: 0)
    # @tire = @bike_city.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @pedals = @bike_city.items.create(name: "Brass Knucks Pedals", description: "They'll make you feel like you're on speed!", price: 150, image: "https://content.competitivecyclist.com/images/items/900/SPP/SPP000A/POL.jpg", inventory: 5)
    # @brakes = @bike_city.items.create(name: "Disc Brakes", description: "They'll stop you on a dime!", price: 70, image: "https://www.excelsports.com/assets/gallery/110464-1.jpg", inventory: 12)
    # @first = Order.create(name: @user.name, address: @user.address, city: @user.city, state: @user.state, zip: @user.zip, user_id: @user.id)
    # @second = Order.create(name: @user.name, address: @user.address, city: @user.city, state: @user.state, zip: @user.zip, user_id: @user.id)
    # @third = Order.create(name: @user.name, address: @user.address, city: @user.city, state: @user.state, zip: @user.zip, user_id: @user.id)
    # @item_order_1 = @first.item_orders.create(item: @tire, price: @tire.price, quantity: 2)
    # @item_order_2 = @second.item_orders.create(item: @pedals, price: @pedals.price, quantity: 2)
    # @item_order_3 = @third.item_orders.create(item: @brakes, price: @brakes.price, quantity: 2)
  end

  it 'merchant admin can deactivate an active item' do
    visit login_path

    fill_in :email, with: 'billobill@gmail.com'
    fill_in :password, with: 'yours'

    click_button 'Login'

    click_link 'Merchant Items'

    within "#merchant-item-#{@pedals.id}" do
      click_link 'Deactivate'

      expect(page).to_not have_content(true)
      expect(page).to have_content(false)
      expect(page).to have_link('Activate')
    end
  end
end
