module V1
  class SessionsController < ApplicationController
    def create
      auth = Authentication.new(user_params)

      if auth.authenticated?
        render json: auth.user, serializer: SessionSerializer
      else
        render json: ErrorSerializer.serialize(invalid: ["credentials"]), status: :unprocessable_entity
      end
    end

    private

    def user_params
      jsonapi_params(only: %i[email password])
    end
  end
end
