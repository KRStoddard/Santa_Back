class AdminSerializer < ActiveModel::Serializer
  attributes :id, :first_name
  has_many :events
end
