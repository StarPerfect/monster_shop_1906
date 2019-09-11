# As an admin user
# When I visit a user's profile page ("/admin/users/5")
# I see the same information the user would see themselves
# I do not see a link to edit their profile
require 'rails_helper'

RSpec.describe 'Admin User Profile View' do
  describe 'when an admin visits a users profile page' do
    it 'can see profile but not edit it' do
      admin = User.create(name:"Administrator", address:"123 tree st", city:"lakewood", state:"CO", zip: "19283", email: "admin_boss@gmail.com", password: "admin", role: 3)
      reg_user = User.create(name: 'Reg Dude', address: '567 boring lane', city: 'Denver', state: 'CO', zip: '80204', email: 'regdude@gmail.com', password: 'fuckingproject')

      visit login_path

      fill_in :email, with: 'admin_boss@gmail.com'
      fill_in :password, with: 'admin'
      visit "/admin/users/#{reg_user.id}"
      # visit admin_user_show_path(reg_user)
save_and_open_page
      expect(page).to_not have_link('Edit Profile')
      expect(page).to have_content(reg_user.name)
      expect(page).to have_content(reg_user.email)
      expect(page).to have_content(reg_user.address)
    end
  end
end
