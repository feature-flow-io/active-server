class AccountPolicy < ApplicationPolicy
  def create?
    user
  end

  def show?
    user.invite_accepted?(record)
  end
end
