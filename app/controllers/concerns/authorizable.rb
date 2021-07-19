module Authorizable
  extend ActiveSupport::Concern

  included do
    include Pundit

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    after_action :verify_authorized, except: :index # rubocop:disable Rails/LexicallyScopedActionFilter
    after_action :verify_policy_scoped, only: :index # rubocop:disable Rails/LexicallyScopedActionFilter
  end

  private

  def user_not_authorized
    render json: ErrorSerializer.serialize(token: ["is invalid"]), status: :unprocessable_entity
  end
end
