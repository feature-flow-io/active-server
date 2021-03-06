module SetCurrentUserDetails
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  private

  def set_current_user
    payload = Token.decode(auth_token)
    Current.user = User.find_by(auth_token: payload["auth_token"])
  rescue JWT::DecodeError
    Current.user = nil
  end

  def auth_token
    @auth_token ||= request.headers.fetch("Authorization", "").split.last
  end
end
