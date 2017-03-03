class ShoppingList < ActiveRecord::Base
  belongs_to :groceries
  belongs_to :user
end
