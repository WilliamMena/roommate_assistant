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

milk = Grocery.create(name: "Milk")
eggs = Grocery.create(name: "Eggs")
cheese = Grocery.create(name: "Cheese")

ShoppingList.create(grocery_id: milk.id, user_id: william.id )
ShoppingList.create(grocery_id: eggs.id, user_id: william.id )
ShoppingList.create(grocery_id: cheese.id, user_id: rocio.id )