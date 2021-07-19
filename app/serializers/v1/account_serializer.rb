module V1
  class AccountSerializer < ActiveModel::Serializer
    attributes :id, :name, :subdomain, :cname, :status, :updated_at, :created_at
    belongs_to :creator
  end
end
