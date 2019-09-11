
require 'rails_helper'

RSpec.describe 'Admin Users' do
  before :each do
    @admin = User.create(name:"Administrator", address:"123 tree st", city:"lakewood", state:"CO", zip: "19283", email: "admin_boss@gmail.com", password: "admin", role: 3)
    @reg_user = User.create(name: 'Reg Dude', address: '567 boring lane', city: 'Denver', state: 'CO', zip: '80204', email: 'regdude@gmail.com', password: 'fuckingproject')
    @employee_user = User.create(name: 'Worker Bee', address: '1111 Hive Drive', city: 'Denver', state: 'CO', zip: '80204', email: 'workerbee@gmail.com', password: 'honey', role: 1)
    @merchant_owner = User.create(name: 'Queen Bee', address: '1111 Hive Drive', city: 'Denver', state: 'CO', zip: '80204', email: 'beyonce@gmail.com', password: 'queenb', role: 2)
  end

  it 'admins can click users link on dashboard to view list of all users' do
    visit login_path

    fill_in :email, with: 'admin_boss@gmail.com'
    fill_in :password, with: 'admin'

    click_button 'Login'

    click_link 'Users'

    expect(page).to have_link(@reg_user.name)
    expect(page).to have_content(@reg_user.created_at)
    expect(page).to have_content('User Type: default')
    expect(page).to have_link(@employee_user.name)
    expect(page).to have_content(@employee_user.created_at)
    expect(page).to have_content('User Type: employee')
    expect(page).to have_link(@merchant_owner.name)
    expect(page).to have_content(@merchant_owner.created_at)
    expect(page).to have_content('User Type: merchant')
  end

# As an admin user
# When I visit a user's profile page ("/admin/users/5")
# I see the same information the user would see themselves
# I do not see a link to edit their profile

  describe 'when an admin visits a users profile page' do
    it 'can see profile but not edit it' do

      visit login_path

      fill_in :email, with: 'admin_boss@gmail.com'
      fill_in :password, with: 'admin'

      visit "/admin/users/#{@reg_user.id}"

      expect(page).to_not have_link('Edit Profile')
      expect(page).to have_content(@reg_user.name)
      expect(page).to have_content(@reg_user.email)
      expect(page).to have_content(@reg_user.address)
    end
  end
end
