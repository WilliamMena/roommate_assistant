class Roommate < ActiveRecord::Base
  belongs_to :user
  belongs_to :roommate, :class_name => "User"
end
