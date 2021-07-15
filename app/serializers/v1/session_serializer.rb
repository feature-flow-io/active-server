module V1
  class SessionSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :auth_token
  end
end
