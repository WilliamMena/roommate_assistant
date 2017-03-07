# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

william = User.create(email: "william@test.com", password: "password", name: "William")
rocio = User.create(email: "rocio@test.com", password: "password", name: "Rocio")
joshua = User.create(email: "joshua@test.com", password: "password", name: "Joshua")
natasha = User.create(email: "natasha@test.com", password: "password", name: "Natasha")
erika = User.create(email: "erika@test.com", password: "password", name: "Erika")
fenix = User.create(email: "fenix@test.com", password: "password", name: "Fenix")
kevin = User.create(email: "kevin@test.com", password: "password", name: "Kevin")
kaylee = User.create(email: "kaylee@test.com", password: "password", name: "Kaylee")

# william = User.find_by_name("William")
# rocio = User.find_by_name("Rocio")
# joshua = User.find_by_name("Joshua")
# natasha = User.find_by_name("Natasha")
# erika = User.find_by_name("Erika")
# fenix = User.find_by_name("Fenix")
# kevin = User.find_by_name("Kevin")
# kaylee = User.find_by_name("Kaylee")



william.roommates.build(roommate_id: rocio.id).save
rocio.roommates.build(roommate_id: william.id).save
william.roommates.build(roommate_id: joshua.id).save



list1 = List.create(title: "Shopping List, Jan 1", user_id: william.id)
# list1.groceries.build(item: "Milk")
# list1.groceries.build(item: "Eggs")
list2 = List.create(title: "Another Shopping List, Nov 22", user_id: rocio.id)
# list2.groceries.build(item: "Cheese")

GroceryItem.create(item: "Milk", list_id: list1.id )
GroceryItem.create(item: "Eggs", list_id: list1.id )
GroceryItem.create(item: "Cheese", list_id: list2.id )
