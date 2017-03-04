class Grocery < ActiveRecord::Base
  has_many :shopping_lists
  has_many :users, through: :shopping_lists
end
