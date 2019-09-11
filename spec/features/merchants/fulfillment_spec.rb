require 'rails_helper'
RSpec.describe 'As a Merchant/Employee' do
  describe "Fulfill an item in an order" do

    it "When all items in an order have been 'fulfilled' by their merchants
    The order status changes from 'pending' to 'packaged'" do

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
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(kate)

      visit employee_dashboard_path
      # save_and_open_page
      # expect(page).to have_content()

    end
    it "Merchant cannot fulfill an order due to lack of inventory, When I visit
     an order show page from my dashboard, For each item of mine in the order,
     If the user's desired quantity is greater than my current inventory quantity for that item
     Then I do not see a 'fulfill' button or link Instead I see a notice next
     to the item indicating I cannot fulfill this item" do

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
     item_order_1 = order_1.item_orders.create(item: tire, price: tire.price, quantity: 2, status: 0)
     item_order_2 = order_2.item_orders.create(item: paper, price: paper.price, quantity: 20, status: 0)
     item_order_3 = order_3.item_orders.create(item: pencil, price: pencil.price, quantity: 5, status: 0)
     item_order_4 = order_2.item_orders.create(item: pencil, price: pencil.price, quantity: 1, status: 0)

     kate = User.create(name: "Kate Long", address: "123 Kate Street", city: "Fort Collins", state: "CO", zip: "80011", email:"kateaswesomegmail.com", password: "ours", role: 1, merchant_id: mike.id)
     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(kate)

     visit employee_dashboard_path

     click_on "#{order_2.id}"

     expect(page).to have_content("Fulfill This Orders Item")

    end
    it "Merchant fulfills part of an order, When I visit an order show page from my dashboard
    For each item of mine in the order, If the user's desired quantity is equal
    to or less than my current inventory quantity for that item, And I have not
    already fulfilled that item: Then I see a button or link to fulfill that
    item, When I click on that link or button I am returned to the order show page
    I see the item is now fulfilled, I also see a flash message indicating that
    I have fulfilled that item the item's inventory quantity is permanently
    reduced by the user's desired quantity, If I have already fulfilled this
    item, I see text indicating such." do

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
    item_order_2 = order_2.item_orders.create(item: paper, price: paper.price, quantity: 20, status: 1)
    item_order_3 = order_3.item_orders.create(item: pencil, price: pencil.price, quantity: 5)
    item_order_4 = order_2.item_orders.create(item: pencil, price: pencil.price, quantity: 1)

    kate = User.create(name: "Kate Long", address: "123 Kate Street", city: "Fort Collins", state: "CO", zip: "80011", email:"kateaswesomegmail.com", password: "ours", role: 1, merchant_id: mike.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(kate)

    visit employee_dashboard_path

    click_on "#{order_2.id}"
    expect(page).to have_content("This item has already been fulfilled")

    click_on "Fulfill This Orders Item"

    expect(current_path).to eq(merchant_order_show_path(order_2))
    end
  end
end
