class GroceryItem < ActiveRecord::Base
  belongs_to :list

  # def buy
  #   bought = true
  #   save
  # end

  # def unbuy
  #   bought = false
  #   save
  # end
end
