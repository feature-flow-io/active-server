module V1
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :updated_at, :created_at
  end
end
