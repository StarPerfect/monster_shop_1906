require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do
  describe 'As a user' do
    before :each do
      @user = User.create!(name:"Santiago", address:"123 tree st", city:"Lakewood", state:"CO", zip: "19283", email:"santamonica@hotmail.com", password: "test", role:0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      @order_1 = @user.orders.create!(name: @user.name, address: @user.address, city: @user.city, state: @user.state, zip: @user.zip, user_id: @user.id)
      @item_order_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
    end

    it 'I can see a merchants statistics' do
      visit "/merchants/#{@meg.id}"

      within ".merchant-stats" do
        expect(page).to have_content("Number of Items: 1")
        expect(page).to have_content("Average Price of Items: $100")
        within ".distinct-cities" do
          expect(page).to have_content("Cities that order these items:")
          expect(page).to have_content("Lakewood")
        end
      end
    end
  end
end
