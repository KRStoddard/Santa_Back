class User < ApplicationRecord
    belongs_to :event
    validates :first_name, uniqueness: {scope: [:last_name, :event]}
end