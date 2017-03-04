class GroceryItem < ActiveRecord::Base
  belongs_to :grocery
  belongs_to :list
end
