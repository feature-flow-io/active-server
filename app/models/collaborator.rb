class Collaborator < ApplicationRecord
  has_secure_token

  belongs_to :user
  belongs_to :account

  enum role: %w[owner editor].index_with { |role| role }

  validates :user, uniqueness: { scope: :account_id, message: "is already in the account" }
end
