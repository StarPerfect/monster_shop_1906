require 'rails_helper'

RSpec.describe "When all items in an order have been fulfilled by their merchants the order status changes from pending to packaged" do
  before(:each) do
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @billy = User.create(name: "Billy Joel", address: "123 Billy Street", city: "Denver", state: "CO", zip: "80011", email:"billobill@gmail.com", password: "yours", role: 1,  merchant_id: @meg.id )
    @user = User.create(name: "Scott Payton", address: "123 Scott Street", city: "Stapleton", state: "CO", zip: "80011", email:"bigfun@gmail.com", password: "mine", role: 0)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    @order = Order.create(name: @user.name, address: @user.address, city: @user.city, state: @user.state, zip: @user.zip, user_id: @user.id)
    @item_order_1 = @order.item_orders.create(item: @tire, price: @tire.price, quantity: 2)
  end

  it "Changes order status when fulfilled" do
    visit login_path

    fill_in :email, with: 'billobill@gmail.com'
    fill_in :password, with: 'yours'

    click_button 'Login'

    click_link "#{@order.id}"

    click_link 'Fulfill This Orders Item'

    click_link 'Logout'

    fill_in :email, with: 'bigfun@gmail.com'
    fill_in :password, with: 'mine'

    click_button 'Login'

    click_link 'My Orders'
    
    expect(page).to have_content('Status: packaged')
  end
end
