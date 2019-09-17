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

      expect(current_path).to eq(edit_address_path(@home))
    end

  end
end
