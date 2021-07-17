module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user
  end

  private

  def authenticate_user
    return if Current.user

    render json: ErrorSerializer.serialize(token: ["is invalid"]), status: :unprocessable_entity
  end
end
