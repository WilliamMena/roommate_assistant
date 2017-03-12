class List < ActiveRecord::Base
  belongs_to :user
  has_many :grocery_items
  has_many :chores

  has_many :list_viewers, :foreign_key => :list_id
  has_many :viewers, through: :list_viewers, :source => :user

  #need to create joins table to hold who can view which posts
  enum list_type: [:shopping, :chore]

  def assign
    array = []
    array = viewers.to_a unless viewers.empty?
    if !viewers.include?(user)
      array << user
    end
    save
    array
  end
end
