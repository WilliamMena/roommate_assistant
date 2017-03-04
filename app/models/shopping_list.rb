class ShoppingList < ActiveRecord::Base
  belongs_to :grocery
  belongs_to :user
end
