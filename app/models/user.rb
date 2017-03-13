class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable,  :trackable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:github]

  validates :name, presence: true
  validates :email, uniqueness: true
  

  has_many :roommates, :class_name => 'Roommate'
  has_many :mates, :through => :roommates, :source => :roommate
  has_many :inverse_roommates, :class_name => "Roommate", :foreign_key => "roommate_id"
  has_many :inverse_mates, :through => :inverse_roommates, :source => :user

  # List the user created
  has_many :lists

  # Lists that the user is shared on
  has_many :list_viewers, :foreign_key => :user_id
  has_many :viewable_lists, through: :list_viewers, :source => :list

  has_many :chores


  # user.roommates.build(roommate_id: user2.id)
  # user.mates returns the user instances of each roommate
  # user.inverse_mates returns the hosts id. Have to figure out how to show all roommates


  # Use the 'map' method to return the requested people

  # create a method along the lines of 'actual_roommates' making each current roommate relationship the beginning stage of a "friend request"
  # 'actual_roommates' could be a method that returns an array of your relationships where both people are following each other
  # compare the methods roommates and inverse_mates to see if each roommate includes the first user and display the roommates who appear on both sides.

  # debate on making anothe model/stable that holds the actual relationships but I feel like it might be unnecesary. 

  # 'pending roommate requests' or 'pending_roommates' (who you haven't added) can be the requests who haven't been approved on both sides yet but mainly checking your 'inverse_roommates' method.

  # 'then create kind of like the opposite for 'roommates' who haven't approved you yet.

  # FOR ALL, if the user presses X (which should be a link next to the request), then the whole relationship will be deleted so it doesn't appear in any method. 

  def actual_roommates
    actual = []
    actual = roommates.map {|r| r.roommate if inverse_mates.include?(r.roommate) == true }
    actual.delete_if {|a| a == nil}
  end

  # if I present the relationship instead of the user, I might be able to destroy it a lot easier.

  def pending_roommates #roommates who are requesting you --- RETURNS THE USER, not the roommate relationship
    pending = []
    pending = inverse_mates.map {|r| r if !actual_roommates.include?(r)}
    pending.delete_if {|r| r == nil}
  end

  def requested_roommates #roommates you're requesting but they haven't approved of yet --- RETURNS THE USER, not the roommate relationship
    pending = []
    pending = roommates.map {|r| r if !actual_roommates.include?(r.roommate)}
    pending.delete_if {|r| r == nil}
  end

  def requested # names of people who you're requesting instead of Roommate Instance
    requested = []
    requested = requested_roommates.map {|r| r.roommate} 
  end

end
