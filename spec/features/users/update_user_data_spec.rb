require 'rails_helper'

RSpec.describe 'Visitor' do
  describe 'User can see the registration page form for their data' do
    before :each do
      @scott = User.create!(name: "scott payton", address: "222 willow st", city: "aurora", state: "CO", zip: 99999, email: "hero@gmail.com", password: "blue")
      @kate = User.create(name: "Kate Long", address: "123 Kate Street", city: "Fort Collins", state: "CO", zip: "80011", email:"kateaswesome@gmail.com", password: "ours", role:2 )

    end

    it 'The form is prepopulated with current info except password' do
      visit login_path

      fill_in :email, with: @scott.email
      fill_in :password, with: @scott.password

      click_button 'Login'

      click_link "Edit Profile"

      fill_in "Name", with: "scott payton"
      fill_in "Address", with: "222 willows st"
      fill_in "City", with: "aurora"
      fill_in "State", with: "LOLOLOL"
      fill_in "Zip", with: 99999
      fill_in "Email", with: "hero@gmail.com"

      click_button "Update Profile"

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("scott payton")
      expect(page).to have_content("222 willows st")
      expect(page).to have_content("LOLOLOL")
      expect(page).to have_content("aurora")
      expect(@scott.zip).to eq("99999")
      expect(page).to have_content("hero@gmail.com")
    end

    it 'I can update my password' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@scott)


      visit profile_path

      expect(page).to have_link("Edit Password")

      click_link "Edit Password"

      expect(current_path).to eq('/profile/edit_password')


      fill_in "Password", with: 'pass'
      fill_in "Password confirmation", with: 'pass'

      click_button "Update Password"

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('Your password is updated!')
    end

  end
end
