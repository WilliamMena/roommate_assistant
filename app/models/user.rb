class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable,  :trackable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :roommates, :class_name => 'Roommate'
  has_many :mates, :through => :roommates, :source => :roommate
  has_many :inverse_roommates, :class_name => "Roommate", :foreign_key => "roommate_id"
  has_many :inverse_mates, :through => :inverse_roommates, :source => :user

  has_many :lists


  # user.roommates.build(roommate_id: user2.id)
  # user.mates returns the user instances of each roommate
  # user.inverse_mates returns the hosts id. Have to figure out how to show all roommates
end
