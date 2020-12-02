class EventSerializer < ActiveModel::Serializer
  attributes :id, :code, :start, :end, :admin_id, :max_price, :notes
end
