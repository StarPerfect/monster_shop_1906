require 'rails_helper'

RSpec.describe 'Merchant Admin can CRUD items' do
  it 'merchant admin can deactivate an active item then reactivate' do
    bike_city = Merchant.create(name: "Meg's Bike City", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    store_admin = User.create(name: "Billy Joel", address: "123 Billy Street", city: "Denver", state: "CO", zip: "80011", email:"billobillgmail.com", password: "yours", role: 2,  merchant_id: bike_city.id )
    user = User.create(name: "Scott Payton", address: "123 Scott Street", city: "Stapleton", state: "CO", zip: "80011", email:"bigfungmail.com", password: "mine", role: 0)
    pedals = bike_city.items.create(name: "Brass Knucks Pedals", description: "They'll make you feel like you're on speed!", price: 150, image: "https://content.competitivecyclist.com/images/items/900/SPP/SPP000A/POL.jpg", inventory: 5)

    visit login_path

    fill_in :email, with: 'billobillgmail.com'
    fill_in :password, with: 'yours'

    click_button 'Login'
save_and_open_page
    click_link 'Merchant Items'

    within "#merchant-item-#{pedals.id}" do
      click_link 'Deactivate'

      expect(page).to_not have_content(true)
      expect(page).to have_content(false)
      expect(page).to have_link('Activate')
    end
  end

  it 'merchant admin can activate an deactive item' do
    bike_city = Merchant.create(name: "Meg's Bike City", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    store_admin = User.create(name: "Billy Joel", address: "123 Billy Street", city: "Denver", state: "CO", zip: "80011", email:"billobillgmail.com", password: "yours", role: 2,  merchant_id: bike_city.id )
    user = User.create(name: "Scott Payton", address: "123 Scott Street", city: "Stapleton", state: "CO", zip: "80011", email:"bigfungmail.com", password: "mine", role: 0)
    brakes = bike_city.items.create(name: "Disc Brakes", description: "They'll stop you on a dime!", price: 70, image: "https://www.excelsports.com/assets/gallery/110464-1.jpg", inventory: 12, active?: false)

    visit login_path

    fill_in :email, with: 'billobillgmail.com'
    fill_in :password, with: 'yours'

    click_button 'Login'

    click_link 'Merchant Items'

    within "#merchant-item-#{brakes.id}" do
      click_link 'Activate'
    end

      expect(page).to_not have_content(false)
      expect(page).to have_content(true)
      expect(page).to have_link('Deactivate')
  end
end
