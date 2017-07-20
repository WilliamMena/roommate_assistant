class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :list_type, :created_at

  has_many :viewers, serializer: UserSerializer
  has_one :user
  has_many :grocery_items
  has_many :chores

end
