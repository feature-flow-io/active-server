class AccountPolicy < ApplicationPolicy
  def create?
    user
  end

  def show?
    user.invite_accepted?(record)
  end

  def update?
    user.invite_accepted?(record) && user.account_owner?(record)
  end
end
