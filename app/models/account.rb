class Account < ApplicationRecord
  RESERVED_SUBDOMAINS = %w[analyzer blog snbn resources assets cdn static status * www feedback app].freeze

  before_validation :normalize_cname

  belongs_to :creator, class_name: "User", optional: true
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  enum status: %w[active inactive].index_with { |role| role }

  validates :name, presence: true, length: { maximum: 255 }
  validates :subdomain, presence: true, uniqueness: { case_sensitive: false }, exclusion: { in: RESERVED_SUBDOMAINS }
  validates :cname, format: { without: /\s/, message: "shouldn't contain spaces" }

  scope :without_pending_collaborators, -> { where.not(collaborators: { joined_at: nil }) }

  private

  def normalize_cname
    self.cname = cname.to_s.downcase.gsub(/\Ahttps?:\/\//, "")
  end
end
