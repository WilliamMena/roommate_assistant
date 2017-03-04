class List < ActiveRecord::Base
  belongs_to :user
  has_many :grocery_items
  has_many :groceries, through: :grocery_items
end
