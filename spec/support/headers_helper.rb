module HeadersHelper
  def authorized_header(user)
    {
      "Authorization" => "Bearer #{Token.encode(auth_token: user.auth_token)}",
      "Content-Type" => "application/json"
    }
  end
end
