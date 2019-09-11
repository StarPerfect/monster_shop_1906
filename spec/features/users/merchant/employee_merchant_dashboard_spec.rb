require 'rails_helper'
RSpec.describe "As an employee" do
  describe 'pending orders' do
    it 'when I visit my merchant dashboard I can see pending orders of items I sell' do
      user = User.create!(name: 'Corina', address: '789 Hungry Way', city: 'Denver', state: 'Colorado', zip: '80205', email: 'Star@gmail.com', password: 'Hello123')
      visit login_path
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button 'Login'
      mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      order_1 = Order.create(name: user.name, address: user.address, city: user.city, state: user.state, zip: user.zip, user_id: user.id, status: 0)
      order_2 = Order.create(name: user.name, address: user.address, city: user.city, state: user.state, zip: user.zip, user_id: user.id, status: 0)
      order_3 = Order.create(name: user.name, address: user.address, city: user.city, state: user.state, zip: user.zip, user_id: user.id, status: 0)
      item_order_1 = order_1.item_orders.create(item: tire, price: tire.price, quantity: 2)
      item_order_2 = order_2.item_orders.create(item: paper, price: paper.price, quantity: 20)
      item_order_3 = order_3.item_orders.create(item: pencil, price: pencil.price, quantity: 5)
      item_order_4 = order_2.item_orders.create(item: pencil, price: pencil.price, quantity: 1)
      kate = User.create(name: "Kate Long", address: "123 Kate Street", city: "Fort Collins", state: "CO", zip: "80011", email:"kateaswesomegmail.com", password: "ours", role: 1, merchant_id: mike.id)

     visit login_path
     fill_in "email", with: kate.email
     fill_in "password", with: kate.password
     click_on "Login"

      expect(current_path).to eq(employee_dashboard_path)
      expect(page).to have_content("Total Items: 21")
      expect(page).to have_content(order_2.id)
      expect(page).to have_content(order_2.created_at)
      expect(page).to have_content(order_2.total_value(mike))
    end
  end
end
