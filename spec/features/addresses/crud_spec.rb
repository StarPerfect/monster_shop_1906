require 'rails_helper'

RSpec.describe 'Addresses Index Page' do
  before :each do
    @user = User.create(name: 'Queen Bee', email: 'beyonce@gmail.com', password: 'queenb')
    @home = Address.create(nickname: 'Home', street: '1111 Hive Drive', city: 'Denver', state: 'CO', zip: '80204')
    @user.addresses << @home
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'From profile, user can view all addresses' do
    visit profile_path

    click_link 'Edit Addresses'

    expect(current_path).to eq(user_addresses_path(@user))
    expect(page).to have_content('Address Nickname: Home')
    expect(page).to have_content('1111 Hive Drive')
    expect(page).to have_css("#address-#{@home.id}")
  end

  it 'can edit an address from the index page' do
    visit profile_path

    click_link 'Edit Addresses'

    within "#address-#{@home.id}" do
      click_link "Edit #{@home.nickname} Address"
    end

    expect(current_path).to eq(edit_address_path(@home))

    fill_in 'Home', with: 'Work'

    click_button 'Update Address'

    expect(current_path).to eq(user_addresses_path(@user))

    within "#address-#{@home.id}" do
      expect(page).to_not have_content('Home')
      expect(page).to have_content('Work')
    end
  end

  it 'can add an address' do
    visit profile_path

    click_link 'Add New Address'

    expect(current_path).to eq("/users/#{@user.id}/addresses/new")

    fill_in 'Nickname', with: "Mom's House"
    fill_in 'Street Address', with: '3043 S 47th Ave'
    fill_in 'City', with: 'Yuma'
    fill_in 'State', with: 'AZ'
    fill_in 'Zip', with: 85364

    click_button 'Add Address'

    moms = Address.last

    expect(current_path).to eq(user_addresses_path(@user))
    expect(page).to have_css("#address-#{moms.id}")
    expect(page).to have_content("Mom's House")
    expect(page).to have_content('Yuma')
  end

  # it 'can delete address from index page only if it has no orders' do
  #   visit profile_path
  #
  #   click_link 'Edit Addresses'
  #
  #   within "#address-#{@home.id}" do
  #     click_link "Delete #{@home.nickname} Address"
  #   end
  # end
end
