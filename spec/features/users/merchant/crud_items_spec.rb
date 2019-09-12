require 'rails_helper'

RSpec.describe "merchant items" do
  describe "when the merchant visits item page" do
    before :each do
      @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @corina = User.create(name: 'Corina Allen', address: '1488 S. Kenton', city: 'Aurora', state: 'CO', zip:'80014', email: 'StarPerfect@gmail.com', password: 'Hello123', role: 2, merchant_id: @bike_shop.id)
      @brakes = @bike_shop.items.create(name: "Disc Brakes", description: "They'll stop you on a dime!", price: 70, image: "https://www.excelsports.com/assets/gallery/110464-1.jpg", inventory: 12)
    end

    it "can delete items that have never been ordered" do

      visit login_path
      fill_in "email", with: @corina.email
      fill_in "password", with: @corina.password
      click_button "Login"

      visit "/merchant/items"

      expect(page).to have_content(@brakes.name)

      click_button "Delete"

      expect(current_path).to eq("/merchant/items")
      expect(page).to have_content("Our big hangry monster has eaten your item!")
      expect(page).to_not have_content(@brakes.name)
    end

    it "merchant can add an item" do
      visit login_path
      fill_in "email", with: @corina.email
      fill_in "password", with: @corina.password
      click_button "Login"

      visit "/merchant/items"

      click_on "Add a new item"
      expect(current_path).to eq(new_item_path)

      expect(page).to have_content("New Item Form")
      fill_in "Name", with: "Lampo"
      fill_in "Price", with: 68
      fill_in "Description", with: "Light bringer, loved by moth"
      fill_in "Inventory", with: 8
      fill_in "Image", with: "https://www.ikea.com/us/en/images/products/hektar-work-lamp-with-wireless-charging-gray__0611545_PE685528_S5.JPG"

      click_on "Create Item"
      new_item = Item.last

      expect(current_path).to eq("/merchant/items")
      expect(page).to have_content("Your new item has saved!")
      expect(page).to have_content(new_item.name)
    end

    it "merchant can edit an item" do

      visit login_path
      fill_in "email", with: @corina.email
      fill_in "password", with: @corina.password
      click_button "Login"

      visit "/merchant/items"

      within "#merchant-item-#{@brakes.id}"do
        click_on "Edit this item"
        expect(current_path).to eq(edit_item_path(@brakes))
      end

      fill_in "Name", with: "Brighto"
      fill_in "Price", with: 68
      fill_in "Description", with: "Light bringer, loved by moth"
      fill_in "Inventory", with: 8
      fill_in "Image", with: "https://www.ikea.com/us/en/images/products/hektar-work-lamp-with-wireless-charging-gray__0611545_PE685528_S5.JPG"

      click_on "Update Item"
      expect(current_path).to eq("/merchant/items")
      new_item = Item.last
    end
  end
end
