class Roommate < ActiveRecord::Base
  belongs_to :user
  belongs_to :roommate, :class_name => "User"

  def self.remove(current_user, user)
    Roommate.find_by(user_id: current_user, roommate_id: user).destroy
    Roommate.find_by(user_id: user, roommate_id: current_user).destroy
  end
end
