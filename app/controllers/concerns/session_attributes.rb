module SessionAttributes
  # used by pundit
  def current_user
    Current.user
  end
end
