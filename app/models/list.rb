class List < ActiveRecord::Base
  belongs_to :user
  has_many :grocery_items

  has_many :list_viewers, :foreign_key => :list_id
  has_many :viewers, through: :list_viewers, :source => :user

  #need to create joins table to hold who can view which posts

  # def viewable
  #   @viewers ||= nil
  # end

  # def viewable_to(array)
  #   @viewers = []
  #   array.delete_if {|u| u.empty? }

  #   array.each do |u|
  #     @viewers << User.find(u)
  #   end
  # end
end
