class Grocery < ActiveRecord::Base
  has_many :grocery_items
  has_many :lists, through: :grocery_items
end
