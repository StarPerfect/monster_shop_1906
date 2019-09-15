require 'rails_helper'

RSpec.describe 'As a visitor I see a link to register on the nav bar' do
  it 'can click register and sign up as a user' do
    visit '/register'

    fill_in 'Name', with: 'Corina Allen'
    fill_in 'Street Address', with: '1488 S Kenton St'
    fill_in 'City', with: 'Aurora'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '80012'
    fill_in 'Email', with: 'StarPerfect@gmail.com'
    fill_in 'Password', with: 'Hello123'
    fill_in 'Confirm Password', with: 'Hello123'

    click_button 'Save Me'

    user = User.last

    expect(current_path).to eq(profile_path)
    expect(page).to have_content('You are now a registered user and have been logged in.')
  end
end

RSpec.describe 'Incomplete registration form' do
  it 'sees a flash notification' do
    visit '/register'

    fill_in 'Name', with: nil
    fill_in 'Street Address', with: '1488 S Kenton St'
    fill_in 'City', with: 'Aurora'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: nil
    fill_in 'Email', with: 'StarPerfect@gmail.com'
    fill_in 'Password', with: nil
    fill_in 'Confirm Password', with: 'Hello123'

    click_button 'Save Me'

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Zip can't be blank")
    expect(page).to have_content("Password can't be blank")
  end
end

RSpec.describe 'Not Unique Email for registration' do
  it 'sees flash notification' do
    billy = User.create(name: "Billy Joel", address: "123 Billy Street", city: "Denver", state: "CO", zip: "80011", email:"billobill@gmail.com", password: "mine" )
    kate = User.create(name: "Kate Long", address: "123 Kate Street", city: "Fort Collins", state: "CO", zip: "80011", email:"kateaswesome@gmail.com", password: "mine4" )
    user = User.create(name:"Santiago", address:"123 tree st", city:"lakewood", state:"CO", zip: "19283", email:"santamonica@hotmail.com", role:3, password: "mine3 ")

    visit "/register"
    fill_in 'Name', with: 'Scotty'
    fill_in 'Street Address', with: '1488 S Kenton St'
    fill_in 'City', with: 'Aurora'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '80011'
    fill_in 'Email', with: "santamonica@hotmail.com"
    fill_in 'Password', with: 'Hello123'
    fill_in 'Confirm Password', with: 'Hello123'
    click_on "Save Me"
    expect(current_path).to eq('/users')
    expect(page).to have_content("Email has already been taken")
    expect(page).to have_button("Save Me")
  end
end
