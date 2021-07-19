class UserPolicy < ApplicationPolicy
  def show?
    current_user? || accepted_collaborators_of_same_account?
  end

  private

  def current_user?
    user == record
  end

  def accepted_collaborators_of_same_account?
    common_account = user.accounts.without_pending_collaborators.ids &
      record.accounts.without_pending_collaborators.ids

    common_account.present?
  end
end
