class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :list_type

  has_many :viewers, serializer: UserSerializer

end
