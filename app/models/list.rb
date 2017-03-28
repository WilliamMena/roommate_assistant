class List < ActiveRecord::Base
  belongs_to :user
  has_many :grocery_items
  has_many :chores

  has_many :list_viewers, :foreign_key => :list_id
  has_many :viewers, through: :list_viewers, :source => :user

  validates :title, presence: true

  enum list_type: [:shopping, :chore]

  # used for assigning List Owner to the collection of users chores can be assigned to
  def assign
    array = []
    array = viewers.to_a unless viewers.empty?
    if !viewers.include?(user)
      array << user
    end
    save
    array
  end

  def self.with_most_items #grocery list
    count = 0
    list = List.new

    where(list_type: 0).each do |l|
      if l.grocery_items.count >= count
        count = l.grocery_items.count
        list = l
      end
    end
    # only returns the list with the most items
    list
  end

  def self.with_most_chores
    count = 0
    list = List.new

    where(list_type: 1).each do |l|
      if l.chores.count >= count
        count = l.chores.count
        list = l
      end
    end
    # returns a hash with all neccesary info
    list_hash = {:list => list, :count => count}
  end

  def self.with_most_list_items
    count = 0
    list = List.new
    list_hash = {}

    all.each do |l|
      if l.chore?
        if l.chores.count >= count
          list = l
          count = l.chores.count
        end
        list_hash = {:list => list, :chore_count => count, :list_type => "Chore"}
      elsif l.shopping?
        if l.grocery_items.count >= count
          list = l
          count = l.grocery_items.count
        end
        list_hash = {:list => list, :item_count => count, :list_type => "Shopping"}
      end
    end
    list_hash
  end
end
