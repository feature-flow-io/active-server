module V1
  class SessionSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :token

    def token
      Token.encode(auth_token: object.auth_token)
    end
  end
end
