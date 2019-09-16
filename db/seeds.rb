# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.destroy_all
User.destroy_all
Merchant.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
pedals = bike_shop.items.create(name: "Brass Knucks Pedals", description: "They'll make you feel like you're on speed!", price: 150, image: "https://content.competitivecyclist.com/images/items/900/SPP/SPP000A/POL.jpg", inventory: 5)
brakes = bike_shop.items.create(name: "Disc Brakes", description: "They'll stop you on a dime!", price: 70, image: "https://www.excelsports.com/assets/gallery/110464-1.jpg", inventory: 12)


#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

#users
# billy = User.create(name: "Billy Joel", address: "123 Billy Street", city: "Denver", state: "CO", zip: "80011", email:"billobill@gmail.com", password: "yours", role: 1,  merchant_id: bike_shop.id )
# corina = User.create(name: 'Corina Allen', address: '1488 S. Kenton', city: 'Aurora', state: 'CO', zip:'80014', email: 'StarPerfect@gmail.com', password: 'Hello123', role: 2, merchant_id: bike_shop.id)
# kate = User.create(name: "Kate Long", address: "123 Kate Street", city: "Fort Collins", state: "CO", zip: "80011", email:"kateaswesome@gmail.com", password: "ours", role: 2, merchant_id: dog_shop.id )
# user = User.create(name:"Santiago", address:"123 tree st", city:"lakewood", state:"CO", zip: "19283", email:"santamonica@hotmail.com", password: "everyone", role: 3)
# scott = User.create(name: "Scott Payton", address: "123 Scott Street", city: "Stapleton", state: "CO", zip: "80011", email:"bigfun@gmail.com", password: "mine", role: 0)
# admin = User.create(name:"Administrator", address:"123 tree st", city:"lakewood", state:"CO", zip: "19283", email: "admin_boss@gmail.com", password: "admin", role: 3)
# reg_user = User.create(name: 'Reg Dude', address: '567 boring lane', city: 'Denver', state: 'CO', zip: '80204', email: 'regdude@gmail.com', password: 'fuckingproject')
# employee_user = User.create(name: 'Worker Bee', address: '1111 Hive Drive', city: 'Denver', state: 'CO', zip: '80204', email: 'workerbee@gmail.com', password: 'honey', role: 1)
# merchant_owner = User.create(name: 'Queen Bee', address: '1111 Hive Drive', city: 'Denver', state: 'CO', zip: '80204', email: 'beyonce@gmail.com', password: 'queenb', role: 2)

billy = User.create(name: "Billy Joel", email:"billobill@gmail.com", password: "yours", role: 1,  merchant_id: bike_shop.id )
billy.addresses.create(nickname: 'home', street: "123 Billy Street", city: "Denver", state: "CO", zip: "80011")
corina = User.create(name: 'Corina Allen', email: 'StarPerfect@gmail.com', password: 'Hello123', role: 2, merchant_id: bike_shop.id)
corina.addresses.create(nickname: 'home', street: '1488 S. Kenton', city: 'Aurora', state: 'CO', zip:'80014')
kate = User.create(name: "Kate Long", email:"kateaswesome@gmail.com", password: "ours", role: 2, merchant_id: dog_shop.id )
kate.addresses.create(nickname: 'home', street: "123 Kate Street", city: "Fort Collins", state: "CO", zip: "80011")
user = User.create(name:"Santiago", email:"santamonica@hotmail.com", password: "everyone", role: 3)
user.addresses.create(nickname: 'home', street: "123 tree st", city:"lakewood", state:"CO", zip: "19283")
scott = User.create(name: "Scott Payton", email:"bigfun@gmail.com", password: "mine", role: 0)
scott.addresses.create(nickname: 'home', street: "123 Scott Street", city: "Stapleton", state: "CO", zip: "80011")
admin = User.create(name:"Administrator", email: "admin_boss@gmail.com", password: "admin", role: 3)
admin.addresses.create(nickname: 'home', street: "123 tree st", city:"lakewood", state:"CO", zip: "19283")
reg_user = User.create(name: 'Reg Dude', email: 'regdude@gmail.com', password: 'fuckingproject')
reg_user.addresses.create(nickname: 'home', street: '567 boring lane', city: 'Denver', state: 'CO', zip: '80204')
employee_user = User.create(name: 'Worker Bee', email: 'workerbee@gmail.com', password: 'honey', role: 1)
employee_user.addresses.create(nickname: 'home', street: '1111 Hive Drive', city: 'Denver', state: 'CO', zip: '80204')
merchant_owner = User.create(name: 'Queen Bee', email: 'beyonce@gmail.com', password: 'queenb', role: 2)
merchant_owner.addresses.create(nickname: 'home', street: '1111 Hive Drive', city: 'Denver', state: 'CO', zip: '80204')
