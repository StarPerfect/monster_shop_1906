RSpec.describe("Order Creation") do
  describe "When I check out from my cart" do
    before :each do
      @user = User.create!(name:"Santiago", address:"123 tree st", city:"Lakewood", state:"CO", zip: "19283", email:"santamonica@hotmail.com", password: "test", role:0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    end

    it 'I can create a new order' do
      visit item_path(@tire)
        click_on "Add To Cart"
      visit item_path(@pull_toy)
        click_on "Add To Cart"
      visit item_path(@dog_bone)
        click_on "Add To Cart"

      visit "/cart"

      click_on "Checkout"

      new_order = Order.last

      expect(current_path).to eq(user_orders_path)
      expect(page).to have_content(new_order.id)
      expect(page).to have_content(new_order.created_at)
      expect(page).to have_content(new_order.status)
      expect(page).to have_content(new_order.grandtotal)
    end
  end
end
